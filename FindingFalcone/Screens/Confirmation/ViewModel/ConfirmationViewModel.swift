//
//  ConfirmationViewModel.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 09/09/23.
//

import Foundation

class ConfirmationViewModel {
    
    var token: String?
    var planetNames : [String] = []
    var vehicleNames : [String] = []
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
    
    func extractPlanetShips(data : [String:String]?) {
        
        self.eventHandler?(.loading)
        
        planetNames.removeAll()
        vehicleNames.removeAll()
        
        guard let data = data else {
            return
        }
        
        for (planetName, vehicleName) in data {
            planetNames.append(planetName)
            vehicleNames.append(vehicleName)
        }
        
        eventHandler?(.dataLoaded)
    }
    
}

extension ConfirmationViewModel {
    
    enum Events {
        case loading
        case dataLoaded
        case error(String?)
    }
    
}
