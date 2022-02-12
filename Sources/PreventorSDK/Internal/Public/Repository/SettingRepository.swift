//
//  SettingRepository.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 9/02/22.
//

import Alamofire

class SettingRepository: PreventorRepository {
    
    func getSettingsGeneral(token: String,
                            success: @escaping(GeneralSettingsResponse) -> Void,
                            failure: @escaping(AFError) -> Void) {
        AF.request(ServiceConstants.generalSettings,
                   method: .get,
                   headers: addHeaders(true, withToken: token)
        ).responseDecodable(of: GeneralSettingsResponse.self) { response in
            self.reciveDefault(response: response, success: success, failure: failure)
        }
    }
    
}
