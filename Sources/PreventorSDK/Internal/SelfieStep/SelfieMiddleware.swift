//
//  SelfieMiddleware.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 12/01/22.
//

import UIKit
//
//final class SelfieMiddleware: PSDKReduxMiddleware<SelfieState> {
//
//    private unowned var repository: PreventorRepository
//    private let max = 30
//    private var count = 0
//
//    init(repository: PreventorRepository) {
//        self.repository = repository
//    }
//
//    override func handleDispatch(action: ReduxAction,
//                                 store: DispatcherObject,
//                                 parent: DispatcherObject?) {
//        guard let action = action as? SelfieAction else { return }
//        switch action {
//        case .validateInfo:
//            validateInfo()
//        default: break
//        }
//    }
//
//    private func validateInfo() {
//        store?.dispatch(SelfieAction.updateScreen(screen: .verifying))
//        var request = repository.readMook(of: OnboardingRequest.self, forName: "OnboardingRequestMook")
//        let shared = PSDKSession.shared
//        request = OnboardingRequest(
//        transactionType: "ONBOARDING",
//        documentType: shared.getDocumentType(),
//        flow: shared.getFlow(),
//        cifcode: shared.getCifCode(),
//        portraits: PortraitsRequest(picture1: shared.getSelfie01(),
//                                    picture2: shared.getSelfie02()),
//        documents: PortraitsRequest(picture1: shared.getDocumentBack(),
//                                    picture2: shared.getDocumentFront()))
//
//        repository.onboarding(
//            request: request!,
//            success: { [weak self] result in
//                if result.status == 400 {
//                    self?.store?.dispatch(SelfieAction.handleResult(resultType: .errorScanDocument))
//                    return
//                }
//                PSDKSession.shared.setOnboardingData(onboardingData: .init(from: result))
//                self?.count = 0
//                self?.callCachedTransaction()
//            },
//            failure: { [weak self] error in
//                if !(self?.handleError(error: error) ?? false ) {
//                    PSDKSession.shared.setOnboardingData(onboardingData: nil)
//                    self?.store?.dispatch(SelfieAction.handleResult(resultType: .errorScanDocument))
//                }
//            })
//    }
//
//    private func onCachedFailed(response: UserDataResponse) {
//        guard let process = response.error?.process,
//              let processType = ProcessType(rawValue: process) else {
//                  biometricsFailed()
//                  return
//              }
//
//        switch processType {
//        case .DOCUMENT_DATA_EXTRACTION:
//            store?.dispatch(SelfieAction.handleResult(resultType: .errorScanDocument))
//        case .GET_TOKEN, .PHOTO_VERIFICATION, .PORTRAIT_UPLOAD, .ENROLLMENT:
//            store?.dispatch(SelfieAction.handleResult(resultType: .errorSelfie))
//        }
//    }
//
//    private func callCachedTransaction() {
//        if count > max {
//            self.biometricsFailed()
//            return
//        }
//        count += 1
//        self.repository.cachedTransaction(
//            ticket: PSDKSession.shared.getTicket(),
//            success: { [weak self] response in
//                guard let status = response.status,
//                      let transactionStatus = TransactionStatus(rawValue: status) else {
//                    self?.callCachedTransaction()
//                    return
//                }
//                switch transactionStatus {
//                case .AWAITING, .VERIFIED:
//                    PSDKSession.shared.setUser(user: response)
//                    self?.store?.dispatch(SelfieAction.handleResult(resultType: .congratulations))
//                case .FAILED:
////#if DEBUG
////                    let data = self?.repository.readMook(of: UserDataModelResponse.self, forName: "UserDataResponse")
////                    PSDKSession.shared.setUser(user: .init(data: data))
////                    self?.store?.dispatch(SelfieAction.handleResult(resultType: .congratulations))
////#else
//                    PSDKSession.shared.setOnboardingData(onboardingData: nil)
//                    self?.onCachedFailed(response: response)
////#endif
//                default:
//                    self?.callCachedTransaction()
//                    break
//                }
//            },
//            failure: { [weak self] error in
//                PSDKSession.shared.setUser(user: nil)
//                PSDKSession.shared.setOnboardingData(onboardingData: nil)
//                if !(self?.handleError(error: error) ?? false ) {
//                    self?.store?.dispatch(SelfieAction.handleResult(resultType: .errorScanDocument))
//                }
//            })
//    }
//
//}
