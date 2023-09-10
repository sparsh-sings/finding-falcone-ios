//
//  ResultAPI+UnitTestCases.swift
//  FindingFalconeTests
//
//  Created by Sparsh Singh on 10/09/23.
//

import XCTest
@testable import FindingFalcone

final class ResultAPI_UnitTestCases: XCTestCase {

    func test_result_api_return_success() {
        
        let param : [String: Any] = [
        "token":
        "HMnmwTKEuhgSrTpkFRRATTuUIJhIgWPl",
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
        
        
        NetworkClass.shared.apiRequest(url: Constant.base_url, params: param, method: .post, responseObject: Status.self, callBack: Callback(onSuccess: { response in
            
            XCTAssertEqual(response.planetName, "Donlon")
            XCTAssertEqual(response.status, "success")
            
            
        }, onFailure: { error in
            XCTFail("Request failed with error: " + error)
            
        }))
        
    }
    
    func test_result_api_return_failure_no_4_planets() {
        
        let param : [String: Any] = [
        "token":
        "HMnmwTKEuhgSrTpkFRRATTuUIJhIgWPl",
        "planet_names": [
        "Donlon",
        "Enchai",
        "Jebing"
        ],
        "vehicle_names": [
        "Space pod",
        "Space rocket",
        "Space shuttle"
        ]
        ]
        
        
        NetworkClass.shared.apiRequest(url: Constant.base_url, params: param, method: .post, responseObject: Status.self, callBack: Callback(onSuccess: { response in
            
            XCTAssertEqual(response.error, "No of Planet names has to be 4")
            
            
        }, onFailure: { error in
            XCTFail("Request failed with error: " + error)
            
        }))
        
    }
    
    func test_result_api_return_failure_no_4_vehicles() {
        
        let param : [String: Any] = [
        "token":
        "HMnmwTKEuhgSrTpkFRRATTuUIJhIgWPl",
        "planet_names": [
        "Donlon",
        "Enchai",
        "Jebing",
        "Sapir"
        ],
        "vehicle_names": [
        "Space pod",
        "Space rocket",
        "Space shuttle"
        ]
        ]
        
        
        NetworkClass.shared.apiRequest(url: Constant.base_url, params: param, method: .post, responseObject: Status.self, callBack: Callback(onSuccess: { response in
            
            XCTAssertEqual(response.error, "No of Vehicle names has to be 4")
            
            
        }, onFailure: { error in
            XCTFail("Request failed with error: " + error)
            
        }))
        
    }
    
}
