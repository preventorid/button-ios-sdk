//
//  PersonalInfoView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/12/21.
//

import Foundation
import SwiftUI

struct PersonalInfoView: BaseView {

    @ObservedObject private(set) var store: ReduxStore<PersonalInfoState>
    let canEdit: Bool
    var userData: UserDataModel = PSDKSession.shared.getUserData()
    var viewKey: ViewKey? { .personalInfo }
    var showPrevButton: Bool {
        canEdit
    }
    let cardPersonalInformation = LanguageManager.shared.language.pages.personalInformation.cardPersonalInformation
    let cardAddress = LanguageManager.shared.language.pages.personalInformation.cardAddress
    let cardDocument = LanguageManager.shared.language.pages.personalInformation.cardDocument
    
    var contentBody: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            ScrollView {
                VStack(spacing: 8){
                    CardView(title: cardPersonalInformation.title, leftImage: .personActive) {
                        VStack(alignment: .leading){
                            PSDKText("\(userData.surname)\n\(userData.firstName) \(userData.middleName)",
                                     font: .psdkH7,
                                     alignment: .leading)
                            Group {
                                Text(userData.gender) +
                                Text(", \(cardPersonalInformation.age) \(userData.age)")
                            }
                            .font(.psdkL3)
                            .foregroundColor(.psdkTextColorPrimaryLight)
                            HStack{
                                VStack(alignment: .leading) {
                                    Text(cardPersonalInformation.nationality)
                                    Text(cardPersonalInformation.dob)
                                }
                                VStack(alignment: .leading) {
                                    Text(userData.nationality)
                                    Text(userData.dateOfBirth)
                                }
                                .padding(.leading, 16)
                            }
                            .font(.psdkL3)
                            .foregroundColor(.psdkTextColorPrimaryLight)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    CardView(title: cardAddress.title, leftImage: .locationOnActive) {
                        VStack(alignment: .leading, spacing: 10){
                            Group {
                                Text(userData.address)
                                Text("\(userData.city), \(userData.state) \(userData.zipCode)")
                            }
                            .font(.psdkL3)
                            .foregroundColor(.psdkTextColorPrimaryLight)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    CardView(title: cardDocument.title, leftImage: .documentNationalActive) {
                        HStack(spacing: 16){
                            VStack(alignment: .leading, spacing: 10) {
                                Group {
                                    Text(cardDocument.idType)
                                    Text(cardDocument.idNumber)
                                    Text(cardDocument.issuingBy)
                                    Text(cardDocument.issuedDate)
                                    Text(cardDocument.expiryDate)
                                }
                                .font(.psdkL3)
                                .foregroundColor(.psdkColorTextLow)
                            }
                            VStack(alignment: .leading, spacing: 10) {
                                Group {
                                    Text(
                                        DocumentModel.DocType(
                                            rawValue: PSDKSession.shared.getDocumentType()
                                        )?.description ?? ""
                                    )
                                    Text(userData.documentNumber)
                                    Text(userData.documentIssuingCountry)
                                    Text(userData.documentIssuingDate)
                                    Text(userData.documentExpirationDate)
                                }
                                .font(.psdkL3)
                                .foregroundColor(.psdkTextColorPrimaryLight)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 26)
                .padding(.horizontal, width * 0.06)
            }
            .frame(width: width , height: height, alignment: .center)
        }
    }
    
    init(store: ReduxStore<PersonalInfoState>) {
        self.store = store
        let verification = VerificationsID.userConfirmation.toVerification
        self.canEdit = verification?.checks.contains(where: { check in
            check.id == ViewID.userInteraction.rawValue
        }) ?? true
        print("canEdit:", canEdit)
    }
    
    func nextAction() {
        if PSDKSession.shared.withFlow() {
            store.parent?.dispatch(ModulePersonalInfoAction.nextScreen)
        } else {
            store.parent?.dispatch(ModulePersonalInfoAction.showStepEmail)
        }
    }
    
    func prevAction() {
        store.parent?.dispatch(ModulePersonalInfoAction.showEditInfo)
    }
    
}
