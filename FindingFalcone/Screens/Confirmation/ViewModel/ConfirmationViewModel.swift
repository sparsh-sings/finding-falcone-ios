//
//  ConfirmationViewModel.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 09/09/23.
//

import Foundation

class ConfirmationViewModel {
    
    var token: String?
    var eventHandler : ((_ events : Events) -> Void)?
    
    func getToken() {
        self.eventHandler?(.loading)
        NetworkClass.shared.apiRequest(url: Constant.base_url + Constant.token, params: [:], method: .post, responseObject: Token.self, callBack: Callback(onSuccess: { response in
            self.token = response.token
            self.eventHandler?(.dataLoaded)
        }, onFailure: { error in
            self.eventHandler?(.error(error))
        }))
    }
    
    
}

extension ConfirmationViewModel {
    
    enum Events {
        case loading
        case dataLoaded
        case error(String?)
    }
    
}
