//
//  EditInfoView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 28/12/21.
//

import Foundation
import SwiftUI

struct EditInfoView: BaseView {
   
    @ObservedObject private(set) var store: ReduxStore<EditInfoState>
    @State var index: Int = 0
    @State var fullName: String = ""
    @State var firstName: String = ""
    @State var middleName: String = ""
    @State var surname: String = ""
    @State var address: String = ""
    @State var state: String = ""
    @State var city: String = ""
    @State var zipcode: String = ""
    @State var nationality: String = ""
    @State var dob: String = ""
    @State var showOptions: Bool = false
    @State var modalRouter: PSDKModalRouter = PSDKModalRouter()
    @State var wasInitialized: Bool = false
    var demiModal: PSDKDemiModal? {
        PSDKDemiModal(presented: $showOptions, router: modalRouter, opacity:  0.2 )
    }
    @State private var item: PSDKCountryTextField.Item? = nil
    let placeHolder = LanguageManager.shared.language.placeholder
    var nextButtonText: String { LanguageManager.shared.language.button.save }
    var title: String {
        switch index {
        case 0: return LanguageManager.shared.language.pages.editPersonalInformation.nameTab.title
        case 1: return LanguageManager.shared.language.pages.editPersonalInformation.addressTab.title
        case 2: return LanguageManager.shared.language.pages.editPersonalInformation.nationalityTab.title
        default: return ""
        }
    }
    
    var contentBody: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack(spacing: 0){
                PSDKText(title, font: .psdkH5)
                    .padding(.top, height * 0.02)
                HStack(spacing: 0) {
                    TabBarButton(icon: .personActive,
                                 isSelected: .constant(index == 0))
                        .onTapGesture {
                            onButtonTapped(index: 0)
                        }
                    TabBarButton(icon: .locationOnActive,
                                 isSelected: .constant(index == 1))
                        .onTapGesture {
                            onButtonTapped(index: 1)
                        }
                    TabBarButton(icon: .calendarTodayActive,
                                 isSelected: .constant(index == 2))
                        .onTapGesture {
                            onButtonTapped(index: 2)
                        }
                }
                .cornerRadius(4)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.psdkWhite)
                        .shadow(color: .psdkShadowBoxButtonColor, radius: 8, x: 1, y: 2)
                )
                .padding(.top, height * 0.0315)
                ScrollView(.vertical){
                    VStack {
                        if index == 0 {
                            PSDKTextField($fullName, hint: placeHolder.fullName)
                            PSDKTextField($firstName, hint: placeHolder.firstName)
                            PSDKTextField($middleName, hint: placeHolder.middleName)
                            PSDKTextField($surname, hint: placeHolder.surname)
                        } else if index == 1 {
                            PSDKTextField($address, hint: placeHolder.address)
                            PSDKTextField($state, hint: placeHolder.state)
                            PSDKTextField($city, hint: placeHolder.city)
                            PSDKTextField($zipcode, hint: placeHolder.city)
                        } else if index == 2 {
                            PSDKCountryTextField(text: $nationality,
                                                 item: $item,
                                                 modalRouter: $modalRouter,
                                                 showDropdown: $showOptions)
                            PSDKTextFieldCalendar(text: $dob,
                                                  hint: placeHolder.dob)
                        }
                    }
                }
                .padding(.top, height * 0.0315)
            }
            .padding(.horizontal, width * 0.067)
            
        }
        .onAppear {
            if !wasInitialized {
                let data = PSDKSession.shared.getUserData()
                self.fullName = "\(data.firstName) \(data.middleName) \(data.surname)"
                self.firstName = data.firstName
                self.middleName = data.middleName
                self.surname = data.surname
                self.address = data.address
                self.state = data.state
                self.city = data.city
                self.zipcode = data.zipCode
                self.nationality = data.nationality
                self.dob = data.dateOfBirth
                if item == nil {
                    item = .init(flag: "🇧🇦", ic: "PE", country: "Bosnia & Herzegovina", code: "387")
                }
                wasInitialized = true
            }
        }
    }
    
    init(store: ReduxStore<EditInfoState>) {
        self.store = store
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation(.linear){
            self.index = index
        }
    }
    
    func nextAction() {
        store.parent?.dispatch(AppFlow.back)
    }

}
