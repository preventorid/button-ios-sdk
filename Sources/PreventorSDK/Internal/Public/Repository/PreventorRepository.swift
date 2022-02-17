//
//  RemoteLogger.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 16/12/21.
//

import Foundation
import Alamofire

class PreventorRepository {
    
    internal func addHeaders(_ show: Bool = false, withToken: String? = nil) -> HTTPHeaders {
        let credentials = PSDKSession.shared.getCredentials()
        let headers: HTTPHeaders = [
            "x-api-key": credentials.xApiKey,
            "x-tenant": credentials.xTenant,
            "x-env": credentials.xEnv,
            "x-banknu": credentials.xBanknu,
            "Authorization": PSDKSession.shared.getToken(withToken),
            //            "xtimezone": TimeZone.current.identifier,
            //            "xinterface": "iOS SDK V0.1.1",
            "Content-Type": "application/json"
        ]
        if show {
            print(headers)
        }
        return headers
    }
    
    func onboarding(request: OnboardingRequest,
                    success: @escaping(_ response: OnboardingResponse) -> Void,
                    failure: @escaping(_ error: AFError) -> Void) {
        AF.request(ServiceConstants.onboarding,
                   method: .post,
                   parameters: request,
                   encoder: JSONParameterEncoder.json,
                   headers: addHeaders()
        ).responseDecodable(of: OnboardingResponse.self) { response in
            self.reciveDefault(response: response, success: success, failure: failure)
        }
    }
    
    func cachedTransaction(ticket: String,
                           success: @escaping(_ response: UserDataResponse) -> Void,
                           failure: @escaping(_ error: AFError) -> Void) {
        let path = ServiceConstants.cachedTransaction.replacingOccurrences(of: "{ticket}", with: ticket)
        AF.request(path,
                   method: .get,
                   parameters: [:],
                   encoding: URLEncoding.queryString,
                   headers: addHeaders())
            .responseDecodable(of: UserDataResponse.self) { response in
                self.reciveDefault(true, response: response, success: success, failure: failure)
            }
    }
    
    func sendOtp(request: OtpRequest,
                 success: @escaping(_ response: OtpResponse) -> Void,
                 failure: @escaping(_ error: AFError) -> Void){
        let path = ServiceConstants.sendOtp.replacingOccurrences(of: "{ticket}", with: PSDKSession.shared.getTicket())
        print("path: ", path, "request: ", request)
        AF.request(path,
                   method: .post,
                   parameters: request,
                   encoder: JSONParameterEncoder.default,
                   headers: addHeaders())
            .responseDecodable(of: OtpResponse.self) { response in
                self.reciveDefault(response: response, success: success, failure: failure)
            }
    }
    
    func validateOtp(request: ValidateOtpRequest,
                     success: @escaping(_ response: ValidateOtpResponse) -> Void,
                     failure: @escaping(_ error: AFError) -> Void
    ) {
        let ticket = PSDKSession.shared.getTicket()
        let path = ServiceConstants.validateOtp.replacingOccurrences(of: "{ticket}", with: ticket)
        print("path: ", path, "request: ", request)
        AF.request(path,
                   method: .post,
                   parameters: request,
                   encoder: JSONParameterEncoder.default,
                   headers: addHeaders())
            .responseDecodable(of: ValidateOtpResponse.self) { response in
                self.reciveDefault(response: response, success: success, failure: failure)
            }
    }
    
    func continueOnboarding(request: ContinueOnboardingRequest,
                            success: @escaping(_ response: ContinueOnboardingResponse) -> Void,
                            failure: @escaping(_ error: AFError) -> Void){
        let ticket = PSDKSession.shared.getTicket()
        let path = ServiceConstants.continueOnboarding.replacingOccurrences(of: "{ticket}", with: ticket)
        print("path: ", path, "request: ", request)
        AF.request(path,
                   method: .post,
                   parameters: request,
                   encoder: JSONParameterEncoder.default,
                   headers: addHeaders())
            .responseDecodable(of: ContinueOnboardingResponse.self) { response in
                self.reciveDefault(response: response, success: success, failure: failure)
            }
    }
    
    func readMook<T: Decodable>(of type: T.Type,
                                forName name: String) -> T? {
        guard let bundle = Bundle.psdkUIKitBundle(),
              let bundlePath = bundle.path(forResource: name, ofType: "json") else {
                  return nil
              }
        do {
            if let json = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return try JSONDecoder().decode(type, from: json)
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    private func showData(data: Data?){
        if let data = data,
           let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print("\n---> response json: " + String(decoding: jsonData, as: UTF8.self))
        } else {
            print("=========> json data malformed")
        }
    }
    
    func reciveDefault<S>(_ showData: Bool = false,
                          response: DataResponse<S, AFError>,
                          success: @escaping(S) -> Void,
                          failure: @escaping(AFError) -> Void) {
        if showData {
            self.showData(data: response.data)
        }
        switch response.result {
        case let .success(result):
            success(result)
        case let .failure(error):
            print(error.localizedDescription)
            failure(error)
        }
    }
    
}
