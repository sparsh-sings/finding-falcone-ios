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
    
    func getVehicleData(distance : Int?, usedRocketDict : [Int:String]) {
        
        self.eventHandler?(.loading)
        
        NetworkClass.shared.apiRequest(url: Constant.base_url + Constant.vehicles, params: [:], method: .get, responseObject: Vehicles.self, callBack: Callback(onSuccess: { response in
            
            let localResponse = response.filter { ($0.maxDistance ?? 0) >= distance ?? 0 }
            self.removeAlreadyUsedItem(localResponse, usedRocketDict)
            self.eventHandler?(.dataLoaded)
            
        }, onFailure: { error in
            
            self.eventHandler?(.error(error))
        }))
    }
    
    private func removeAlreadyUsedItem(_ response : Vehicles, _ dictionary : [Int:String]) {
        
        var newResponse = response
        
        let countDictionary = CommonFunction.shared.countOccurrences(dictionary: dictionary)
        
        for (index, vehicle) in newResponse.enumerated().reversed() {
            if vehicle.totalNo == countDictionary[vehicle.name ?? ""] {
                newResponse.remove(at: index)
            }
        }
        
        self.vehicles = newResponse
    }
    
}

extension VehicleViewModel {
    
    enum Events {
        case loading
        case dataLoaded
        case error(String?)
    }
    
}
