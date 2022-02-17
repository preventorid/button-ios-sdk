//
//  RoutingManager.swift
//  
//
//  Created by Alexander Rodriguez on 10/02/22.
//

import Foundation

class RoutingManager {
    
    let workflow: Workflow
    var verification: VerificationModel
    var verificationIndex: Int = 1
    var checkIndex: Int = 0
    var maxCheckIndex: Int
    let maxVerificationIndex: Int
    
    init?() {
        guard let workflow = PSDKSession.shared.currentWorkflow,
                let verification = workflow.verifications.first else {
            return nil
        }
        self.workflow = workflow
        self.verification = verification
        self.maxCheckIndex = verification.checks.count
        self.maxVerificationIndex = workflow.verifications.count
    }
    
    func getNextScreen() -> ViewID? {
        if let vid = goToNextCheck() {
            return vid
        } else {
            nextVerification()
            return .nextModule
        }
    }
    
    private func goToNextCheck() -> ViewID? {
        var vid: ViewID? = nil
        while vid == nil && checkIndex < maxCheckIndex {
            if let aux = ViewID(rawValue: verification.checks[checkIndex].id) {
                vid = aux
            }
            checkIndex += 1
        }
        return vid
    }
    
    private func nextVerification() {
        var findValue: Bool = false
        while !findValue && verificationIndex < maxVerificationIndex {
            let aux = workflow.verifications[verificationIndex]
            if let verificationID = VerificationsID(rawValue: aux.id), verificationID.isFlowPart {
                verification = aux
                maxCheckIndex = verification.checks.count
                checkIndex = 0
                findValue = true
            }
            verificationIndex += 1
        }
    }
    
    func forcePosition(verificationId: VerificationsID, check: ViewID) {
        if let verification = verificationId.toVerification {
            self.verification = verification
            verificationIndex = verification.orderNumber
            checkIndex = check.toCheck(from: verification)?.orderNumber ?? 0
            maxCheckIndex = verification.checks.count
        }
    }
    
}
