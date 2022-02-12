//
//  LanguageRepository.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 9/02/22.
//

import Alamofire

class LanguageRepository: PreventorRepository {
    
    private let baseUrl = ServiceConstants.LANGUAGE_CENTER_FILE
    private let apiGetLanguage = "/i18n/{language}"
    
    func getLanguage(language: AppLanguage,
                     success: @escaping(Language) -> Void,
                     failure: @escaping(AFError) -> Void) {
        let url = baseUrl + apiGetLanguage.replacingOccurrences(of: "{language}", with: "\(language.rawValue).json")
        print(url)
        AF.request(url,
                   method: .get
        ).responseDecodable(of: Language.self) { response in
            self.reciveDefault(response: response, success: success, failure: failure)
        }
    }
    
}
