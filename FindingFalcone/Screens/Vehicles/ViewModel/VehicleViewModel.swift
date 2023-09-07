//
//  VehicleViewModel.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 07/09/23.
//

import Foundation

class VehicleViewModel {
    
    var vehicles : Vehicles = []
    var eventHandler : ((_ events : Events) -> Void)?
    
    func getVehicleData(distance : Int?) {
        self.eventHandler?(.loading)
        NetworkClass.shared.apiRequest(url: Constant.base_url + Constant.vehicles, params: [:], method: .get, responseObject: Vehicles.self, callBack: Callback(onSuccess: { response in
            self.vehicles = response.filter { ($0.maxDistance ?? 0) >= distance ?? 0 }
            self.eventHandler?(.dataLoaded)
        }, onFailure: { error in
            self.eventHandler?(.error(error))
        }))
    }
    
}

extension VehicleViewModel {
    
    enum Events {
        case loading
        case dataLoaded
        case error(String?)
    }
    
}
