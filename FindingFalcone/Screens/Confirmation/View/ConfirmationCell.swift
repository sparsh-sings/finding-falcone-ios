//
//  ConfirmationCell.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 09/09/23.
//

import UIKit

class ConfirmationCell: UITableViewCell {

    @IBOutlet weak var vehicleImage: UIImageView!
    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var vehicleNameLabel: UILabel!
    @IBOutlet weak var planetNameLabel: UILabel!
    
    var vehicleName : String? {
        didSet {
            vehicleImage.image = UIImage(named: vehicleName?.lowercased().replacingOccurrences(of: " ", with: "") ?? "")
            vehicleNameLabel.text = vehicleName
        }
    }
    
    var planetName : String? {
        didSet {
            planetImage.image = UIImage(named: planetName?.lowercased().replacingOccurrences(of: " ", with: "") ?? "")
            planetNameLabel.text = planetName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
