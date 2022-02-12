//
//  Session.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 20/01/22.
//

import Foundation
import UIKit

class PSDKSession {
    
    static let shared = PSDKSession()
    private var user: User
    private var session: Session
    private var databaseState: PSDKResultState = .none
    var initializeState: PSDKResultState = .none
    var generalConfig: GeneralSettingsResponse? = nil
    var currentWorkflow: Workflow? = nil
    
    init() {
        user = User()
        session = Session()
    }
    
    func clear() {
        user = .init()
        session = .init()
    }
    
    func setGeneralConfig(generalConfig: GeneralSettingsResponse) {
        self.generalConfig = generalConfig
        if user.config.flowType.isEmpty {
            currentWorkflow = generalConfig.defaultWorkflow
        } else {
            currentWorkflow = generalConfig.workflows.first(
                where: { flow in
                    flow.id == user.config.flowType
                }) ?? generalConfig.defaultWorkflow
        }
    }
    
    func setInitializeResult(status: PSDKResultState) {
        initializeState = status
    }
    
    func getInitializeResult() -> PSDKResultState {
        initializeState
    }
    
    func loadConfig(config: Config) {
        user.config = config
    }
    
    func getUserSession() -> User {
        return user
    }

    func getCredentials() -> Credentials {
        user.config.credentials
    }
    
    func setOnboardingData(onboardingData: OnboardingData?) {
        user.onboardingData = onboardingData
    }
    
    func setUser(user: UserDataResponse?) {
        if let user = user, let data = user.data {
            self.user.data = .init(from: data)
            self.user.ocrValidations = user.ocrValidations
        } else {
            self.user.data = .init()
            self.user.ocrValidations = []
        }
    }
    
    func setUserData(data: UserDataModel){
        self.user.data = data
    }
    
    func getUserData() -> UserDataModel {
        user.data
    }
    
    
    func setDatabaseState(databaseState: PSDKResultState) {
        self.databaseState = databaseState
    }
    
    func getDatabaseState() -> PSDKResultState {
        self.databaseState
    }
    
    func getTicket() -> String {
        user.onboardingData?.ticket ?? ""
    }
    
    private func getAuth() -> String{
        "\(user.config.credentials.xApiKey):\(user.config.credentials.secret)".toBase64()
    }
    
    func getToken(_ customToken: String? = nil) -> String {
        if let token = customToken ?? user.onboardingData?.token {
            return "Bearer \(token)"
        } else {
            let auth = getAuth()
            return "Basic \(auth)"
        }
    }
    
    func setEmail(email: String) {
        session.email = email
    }
    
    func setPhone(phone: String) {
        session.phone = phone
    }
    
    func getEmail() -> String? {
        session.email
    }
    
    func getPhone() -> String? {
        session.phone
    }
    
    func getPhoneCountryCode() -> String? {
        session.phoneCountryCode
    }
    
    func setPhoneCountryCode(phoneCountryCode: String) {
        session.phoneCountryCode = phoneCountryCode
    }
    
    func setDocumentType(documentType: String) {
        session.documentType = documentType
    }
    
    func getDocumentType() -> String {
        session.documentType ?? ""
    }
    
    func getQuantity() -> DocumentModel.Quantity {
        DocumentModel.DocType(rawValue: getDocumentType())?.quantity ?? .two
    }
    
    func setDocumentIssuingCountry(issuingCountry: String) {
        session.issuingCountry = issuingCountry
    }
    
    func getDocumentIssuingCountry() -> String? {
        session.issuingCountry
    }
    
    func setDocumentFront(image: UIImage) {
        session.documentFront = toBase64(image)
    }
    
    func getDocumentFront() -> String? {
        session.documentFront
    }
    
    func setDocumentBack(image: UIImage) {
        if getQuantity() == .two {
            session.documentBack = toBase64(image)
        }
    }
    
    func getDocumentBack() -> String? {
        session.documentBack
    }
    
    func setSelfie01(image: UIImage) {
        session.selfie01 = toBase64(image)
    }
    
    func getSelfie01() -> String? {
        session.selfie01
    }
    
    func setSelfie02(image: UIImage) {
        session.selfie02 = toBase64(image)
    }
    
    func getSelfie02() -> String? {
        session.selfie02
    }
    
    func getFlow() -> String {
        user.config.flowType
    }
    
    func getCifCode() -> String {
        user.config.cifCode
    }
    
    private func toBase64(_ image: UIImage) -> String? {
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            var strBase64 = imageData.base64EncodedString()
            strBase64 = "data:image/jpeg;base64," + strBase64
            return strBase64
        }
        return nil
    }
    
    struct Session {
        
        var documentType: String?
        var issuingCountry: String?
        var documentBack: String?
        var documentFront: String?
        var selfie01: String?
        var selfie02: String?
        var email: String?
        var phoneCountryCode: String?
        var phone: String?
        
    }
    
}
