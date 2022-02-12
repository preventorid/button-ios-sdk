//
//  ActicityObserver.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 16/12/21.
//

import Foundation
import UIKit

class ActivityObserver: WindowDelegate {
    
    enum IdlenessType: Int {
        
        case onboarding = 0
        case home = 1
        case cardPurchase = 2
        
        var timeout: Double {
            switch self {
            case .onboarding:
                return 60*15
            case .home:
                return 60*5
            case .cardPurchase:
                return 60*5
            }
        }
        
    }
    
    static private var shared = ActivityObserver()
    
    var window: PSDKWindow?
    
    private var type: IdlenessType = .home
    
    private let dispatchQueue: DispatchQueue = DispatchQueue.global(qos: .userInteractive)
    private var dispatchWorkItemIdleness: DispatchWorkItem = DispatchWorkItem { }
    
    init(window: PSDKWindow? = nil) {
        self.window = window
        self.window?.delegate = self
    }
    
    static func setup(window: PSDKWindow) {
        shared.window = window
        shared.window?.delegate = shared
    }
    
    static func stop() {
        shared.window?.delegate = nil
        shared.dispatchWorkItemIdleness.cancel()
    }
    
    static func start(type: IdlenessType) {
        shared.window?.delegate = shared
        shared.type = type
        shared.dispatchWorkItemIdleness.cancel()
        shared.dispatchQueue.asyncAfter(deadline: .now() + type.timeout, execute: shared.dispatchWorkItemIdleness)
        
    }
    
    func receiveTouchEvent(with event: UIEvent?) {
        ActivityObserver.start(type: self.type)
    }
    
}

protocol WindowDelegate: AnyObject {
    func receiveTouchEvent(with event: UIEvent?)
}

class PSDKWindow: UIWindow {
    
    weak var delegate: WindowDelegate?
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        self.delegate?.receiveTouchEvent(with: event)
        return view
    }
    
}
