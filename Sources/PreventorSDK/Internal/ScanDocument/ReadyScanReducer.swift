//
//  ReadyScanReducer.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/12/21.
//

class ReadyScanReducer: ReduxReducer<ReadyScanState> {
    
    override func reduce(state: ReadyScanState, action: ReduxAction) -> ReadyScanState {
        guard let action = action as? ReadyScanAction else { return state }
        switch action {
        case let .updateScreen(screen):
            return .init(screen: screen,
                         type: state.type)
        case let .showFrontPhoto(image):
            return .init(
                screen: .showFrontPhoto,
                type: state.type,
                image: image)
        case let .showBackPhoto(image):
            return .init(
                screen: .showBackPhoto,
                type: state.type,
                image: image)
        case .showRegulaScan:
            return .init(
                screen: .ready,
                type: state.type,
                scanMode: state.scanMode,
                showRegulaScan: true
            )
        case .hiddeRegulaScan(_):
            return .init(
                screen: .ready,
                type: state.type,
                scanMode: state.scanMode,
                showRegulaScan: false
            )
        default: return state
        }
    }
    
}
