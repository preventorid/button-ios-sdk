//
//  PersonalInfoReducer.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 24/12/21.
//

class PersonalInfoReducer: ReduxReducer<PersonalInfoState> {
    
    override func reduce(state: PersonalInfoState, action: ReduxAction) -> PersonalInfoState {
        guard let action = action as? PersonalInfoAction else { return state }
        switch action {
        case let .handleResult(resultType):
            return .init(screen: .result,
                         resultType: resultType)
        default:
            return state
        }
    }
}
