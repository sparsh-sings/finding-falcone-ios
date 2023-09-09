//
//  PlanetCell.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 06/09/23.
//

import UIKit

class PlanetCell: UICollectionViewCell {

    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var planetDistance: UILabel!
    @IBOutlet weak var vehicleImage: UIImageView!
    
    var planets: PlanetElement? {
        didSet {
            planetSetup()
        }
    }
    
    var vehicles: String? {
        didSet {
            vehicleImage.image = UIImage(named: vehicles?.lowercased().replacingOccurrences(of: " ", with: "") ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func planetSetup() {
        guard let planets = planets else { return }
        planetName.text = planets.name
        planetDistance.text = String(planets.distance ?? 0) + " Megamiles"
        planetImage.image = UIImage(named: planets.name?.lowercased() ?? "no_image")
    }
    
}
