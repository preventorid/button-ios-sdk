//
//  RoutingManager.swift
//  
//
//  Created by Alexander Rodriguez on 10/02/22.
//

import Foundation

class RoutingManager {
    
    let verification: VerificationModel
    var verificationIndex: Int = 0
    var checkIndex: Int = 0
    let maxCheckIndex: Int
    
    init?(verification: VerificationModel?,
          maxCheckIndex: Int? = nil) {
        guard let verification = verification else {
            return nil
        }
        self.verification = verification
        if let maxCheckIndex = maxCheckIndex {
            self.maxCheckIndex = maxCheckIndex
        } else {
            self.maxCheckIndex = verification.checks.count
        }
    }
    
    func getNextScreen() -> ViewID? {
        var vid: ViewID? = nil
        if checkIndex < maxCheckIndex {
            vid = .init(rawValue: verification.checks[checkIndex].id)
            checkIndex += 1
        } else {
            vid = .nextModule
        }
        return vid
    }
    
}
