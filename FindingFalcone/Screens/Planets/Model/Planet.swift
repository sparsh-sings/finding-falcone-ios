//
//  Planet.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 06/09/23.
//

import Foundation

struct PlanetElement: Codable {
    let name: String?
    let distance: Int?
}

typealias Planet = [PlanetElement]
