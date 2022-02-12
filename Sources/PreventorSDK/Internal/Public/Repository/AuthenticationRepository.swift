//
//  AuthenticationRepository.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 9/02/22.
//

import Alamofire

class AuthenticationRepository: PreventorRepository {
    
    private let baseUrl = ServiceConstants.BASE_URL
    private let validateApiKey = "/id/v1/identity/auth/validate-key"
    private let authToken = "/id/v1/identity/auth/token"
    
    
    func validateApiKey(success: @escaping(ApiKeyResponse) -> Void,
                        failure: @escaping(AFError) -> Void) {
        AF.request(baseUrl + validateApiKey,
                   method: .post,
                   headers: addHeaders(true)
        ).responseDecodable(of: ApiKeyResponse.self) { response in
            self.reciveDefault(response: response, success: success, failure: failure)
        }
    }
    
    func authToken(success: @escaping(AuthTokenResponse) -> Void,
                   failure: @escaping(AFError) -> Void) {
        AF.request(baseUrl + authToken,
                   method: .post,
                   headers: addHeaders()
        ).responseDecodable(of: AuthTokenResponse.self) { response in
            self.reciveDefault(response: response, success: success, failure: failure)
        }
    }
    
}
