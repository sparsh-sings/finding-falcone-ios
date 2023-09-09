//
//  VehicleSelectedProtocol.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 08/09/23.
//

import Foundation

protocol VehicleSelectedProtocol : AnyObject {
    func didSelectVehicle(planetIndex: Int, vehicleName: String)
}
