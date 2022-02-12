//
//  PreventorSDK.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 4/02/22.
//

import Foundation
import UIKit

public struct PreventorSDKConfig {
    
    let flowType: String
    let cifCode: String
    let apiKey: String
    let tenant: String
    let env: String
    let banknu: String
    let secret: String
    
    public init(flowType: String,
                cifCode: String,
                apiKey: String,
                tenant: String,
                env: String,
                banknu: String,
                secret: String
    ) {
        self.flowType = flowType
        self.cifCode = cifCode
        self.apiKey = apiKey
        self.tenant = tenant
        self.env = env
        self.banknu = banknu
        self.secret = secret
    }
    
    func isValid() -> Bool {
        !(flowType.isEmpty || cifCode.isEmpty || apiKey.isEmpty || tenant.isEmpty || env.isEmpty || banknu.isEmpty || secret.isEmpty)
    }
    
}

public enum PreventorSDKErrorCode: String {
    
    case CANCELLED_BY_USER
    case BIOMETRIC_AUTHENTICATION_FAILED
    case BAD_STEP_BY_USER
    case MISSING_PARAMETERS
    
}

public enum  PSDKResultState {
    
    case none
    case loading
    case success
    case failed
    
}

public class PreventorSDK {
    
    public static let shared: PreventorSDK = .init()
    
    var delegate: PreventorSDKDelegate? = nil
    
    init() {
        print(ServiceConstants.envPath)
    }
    
    public func callBack(delegate: PreventorSDKDelegate) {
        PreventorSDK.shared.delegate = delegate
    }
    
    private func getSettingsGeneral(token: String,
                                    complete: @escaping ( PSDKResultState) -> Void){
        let repository = SettingRepository()
        repository.getSettingsGeneral(
            token: token,
            success: { result in
                PSDKSession.shared.setGeneralConfig(generalConfig: result)
                PSDKSession.shared.setInitializeResult(status: .success)
                complete(.success)
            },
            failure: { error in
                PSDKSession.shared.setInitializeResult(status: .failed)
            })
    }
    
    private func getToken(complete: @escaping ( PSDKResultState) -> Void) {
        let repository = AuthenticationRepository()
        repository.authToken(
            success: { result in
                self.getSettingsGeneral(token: result.token, complete: complete)
            },
            failure: { error in
                PSDKSession.shared.setInitializeResult(status: .failed)
            })
    }
    
    public func initialize(config: PreventorSDKConfig,
                           complete: @escaping ( PSDKResultState) -> Void) {
        PSDKSession.shared.loadConfig(config: .init(flowType: config.flowType,
                                                    credentials: .init(
                                                        xApiKey: config.apiKey,
                                                        xTenant: config.tenant,
                                                        xEnv: config.env,
                                                        xBanknu: config.banknu,
                                                        secret: config.secret),
                                                    cifCode: config.cifCode))
        PSDKSession.shared.initializeState = .loading
        LanguageManager.shared.setLanguage(
            complete: { status in
                if status == .failed {
                    PSDKSession.shared.initializeState = status
                    return
                }
                self.getToken(complete: complete)
            })
        UIFont.loadFonts()
    }
    
    public func validateApiKey(complete: @escaping (Bool) -> Void) {
        let repository = AuthenticationRepository()
        repository.validateApiKey(
            success: { _ in
                complete(true)
            }, failure: { error in
                complete(false)
            })
    }
    
}
