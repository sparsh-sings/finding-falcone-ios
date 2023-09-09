//
//  ResultViewModel.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 09/09/23.
//

import Foundation

class ResultViewModel {
    
    func getResultStatus(token: String) {
        
        let param : [String : Any] = [
            "token": token,
            "planet_names": [
            "Donlon",
            "Enchai",
            "Jebing",
            "Sapir"],
            "vehicle_names": [
            "Space pod",
            "Space rocket",
            "Space shuttle",
            "Space ship"]
        ]
        
        NetworkClass.shared.apiRequest(url: Constant.base_url + "find", params: param, method: .post, responseObject: Status.self, callBack: Callback(onSuccess: { response in
            debugPrint(response)
            
        }, onFailure: { error in
            debugPrint(error)
        }))
        
    }
    
}
