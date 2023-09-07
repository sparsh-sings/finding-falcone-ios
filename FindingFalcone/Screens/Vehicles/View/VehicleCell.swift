//
//  VehicleCell.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 07/09/23.
//

import UIKit

class VehicleCell: UICollectionViewCell {
    
    @IBOutlet weak var vehicleImage: UIImageView!
    @IBOutlet weak var vehicleName: UILabel!
    @IBOutlet weak var maxDistance: UILabel!
    @IBOutlet weak var speed: UILabel!
    
    var vehicles : Vehicle? {
        didSet {
            updateCell()
        }
    }
    
    var isItemSelected : Bool? {
        didSet {
            if isItemSelected ?? false {
                self.layer.borderWidth = 2.0
                self.layer.borderColor = UIColor.systemGreen.cgColor
            } else {
                self.layer.borderWidth = 0.0
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func updateCell() {
        guard let vehicles else { return }
        vehicleName.text = vehicles.name
        vehicleImage.image = UIImage(named: vehicles.name?.lowercased().replacingOccurrences(of: " ", with: "") ?? "no_image")
        maxDistance.text = String(vehicles.maxDistance ?? 0) + " Megamiles"
        speed.text = String(vehicles.speed ?? 0) + " Megamiles/Hour"
    }

}
