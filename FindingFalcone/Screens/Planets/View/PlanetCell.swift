//
//  PlanetCell.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 06/09/23.
//

import UIKit

class PlanetCell: UITableViewCell {

    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var planetDistance: UILabel!
    
    var planets: PlanetElement? {
        didSet {
            planetSetup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func planetSetup() {
        guard let planets = planets else { return }
        planetName.text = planets.name
        planetDistance.text = String(planets.distance ?? 0) + " Megamiles"
        planetImage.image = UIImage(named: planets.name?.lowercased() ?? "")
    }
    
}
