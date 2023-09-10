//
//  Status.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 09/09/23.
//

import Foundation

struct Status: Codable {
    let planetName, status, error: String?

    enum CodingKeys: String, CodingKey {
        case planetName = "planet_name"
        case status
        case error
    }
}
