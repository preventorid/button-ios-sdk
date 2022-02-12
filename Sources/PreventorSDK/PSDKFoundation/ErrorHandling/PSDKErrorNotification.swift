//
//  PSDKErrorNotification.swift
//  PSDKFoundation
//
//  Created by Alexander Rodriguez on 15/12/21.
//

import Foundation
import Combine

enum PSDKErrorNotification: String {
    
    case sessionInactivity = "session_inactivity"
    case sessionExpired = "session_expired"
    case noInternetConnection = "no_internet_connection"
    case genericError = "generic_error"
    case userAlreadyLogged = "user_already_logged"
    
    var name: Notification.Name {
        return Notification.Name(rawValue)
    }
    
}

extension NotificationCenter {
    
    func postErrorNotification(_ errorNotification: PSDKErrorNotification) {
        self.post(Notification(name: errorNotification.name))
    }
    
    func postErrorNotification(from error: PSDKError) -> Bool {
        guard let notification = PSDKErrorNotification(rawValue: error.code.lowercased()) else {
            return false
        }
        postErrorNotification(notification)
        return true
    }
    
    func subscribeTo(_ errorNotification: PSDKErrorNotification, handler: @escaping (Notification) -> Void) -> AnyCancellable {
        self.publisher(for: errorNotification.name)
            .sink { (notification) in
                handler(notification)
        }
    }
    
}
