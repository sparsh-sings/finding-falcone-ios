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
        NetworkClass.shared.apiRequest(url: "https://findfalcone.geektrust.com/planets", params: [:], method: .get, responseObject: Planet.self, callBack: Callback(onSuccess: { success in
            self.planets = success
            self.eventHandler?(.dataLoading)
        }, onFailure: { error in
            self.eventHandler?(.error(error))
        }))
        
    }
    
}

extension PlanetViewModel {
    
    enum Events {
        case loading
        case dataLoading
        case error(String?)
    }
}
