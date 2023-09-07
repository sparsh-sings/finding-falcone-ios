//
//  Vehicles.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 07/09/23.
//

import Foundation

struct Vehicle: Codable {
    let name: String?
    let totalNo, maxDistance, speed: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case totalNo = "total_no"
        case maxDistance = "max_distance"
        case speed
    }
}

typealias Vehicles = [Vehicle]
