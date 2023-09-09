//
//  PlanetViewModel.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 06/09/23.
//

import Foundation

class PlanetViewModel {
    
    var planets : Planet = []
    var indexWithVehicle : [Int : String] = [:]
    
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
    
    func mapdata() -> [String: String] {
        
        var mappedRocketDict = [String: String]()
        
        let keyToPlanetMapping: [Int: String] = Dictionary(uniqueKeysWithValues: planets.enumerated().map { (index, planetDict) in
            let planetName = planets[index].name!
            return (index, planetName)
        })

        for (key, rocketName) in indexWithVehicle {
            if let planetName = keyToPlanetMapping[key] {
                mappedRocketDict[planetName] = rocketName
            }
        }
        
        debugPrint(mappedRocketDict)
        return mappedRocketDict
    }
    
}

extension PlanetViewModel {
    
    enum Events {
        case loading
        case dataLoaded
        case error(String?)
    }
}
