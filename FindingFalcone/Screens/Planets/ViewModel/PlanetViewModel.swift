//
//  PlanetViewModel.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 06/09/23.
//

import Foundation

class PlanetViewModel {
    
    var planets : Planet = []
    var eventHandler : ((_ event : Events) -> Void)?
    
    func getPlanetList() {
        self.eventHandler?(.loading)
        NetworkClass.shared.apiRequest(url: Constant.base_url + Constant.planets, params: [:], method: .get, responseObject: Planet.self, callBack: Callback(onSuccess: { success in
            self.planets = success
            self.eventHandler?(.dataLoaded)
        }, onFailure: { error in
            self.eventHandler?(.error(error))
        }))
        
    }
    
}

extension PlanetViewModel {
    
    enum Events {
        case loading
        case dataLoaded
        case error(String?)
    }
}
