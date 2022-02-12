//
//  ChooseCountryView.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 22/12/21.
//

import SwiftUI

struct ChooseCountryView: BaseView {

    var viewKey: ViewKey? {
        .chooseCountry
    }
    
    @State var country: String = ""
    @ObservedObject private(set) var store: ReduxStore<CameraDeniedState>
    @State var showDropdown: Bool = false
    @State var modalRouter: PSDKModalRouter = PSDKModalRouter()
    var demiModal: PSDKDemiModal? {
        PSDKDemiModal(presented: $showDropdown, router: modalRouter, opacity:  0.8 )
    }
    @State private var item: PSDKCountryTextField.Item? = nil
    let textManager: PrepareSteps = LanguageManager.shared.language.pages.prepareSteps
    
    var contentBody: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            ScrollView(.vertical){
                VStack {
                    PSDKText(LanguageManager.shared.language.pages.chooseCountry.title,
                             font: .psdkH5)
                        .padding(.top, height * 0.02)
                    Image.worldCountries
                        .padding(.top, height * 0.03)
                    PSDKText(LanguageManager.shared.language.pages.chooseCountry.subTitle, font: .psdkH7)
                        .padding(.top, height * 0.0211)
                        .padding(.horizontal, width * 0.03)
                    PSDKCountryTextField(
                        text: $country,
                        item: $item,
                        modalRouter: $modalRouter,
                        showDropdown: $showDropdown
                    )
                        .padding(.top, height * 0.03)
                }
                .padding(.horizontal, width * 0.06)
            }
        }
    }
    
    
    func nextAction() {
        if let item = item {
            PSDKSession.shared.setDocumentIssuingCountry(issuingCountry: item.ic)
            store.parent?.dispatch(StepDocumentAction.showDocumentType)
        }
    }
    
}
