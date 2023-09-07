//
//  VehicleVC.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 06/09/23.
//

import UIKit

class VehicleVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var planetImage: UIImageView!
    
    var planet : PlanetElement?
    var selectedIndexPath: Int?
    
    var viewModel = VehicleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateConfigurations()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension VehicleVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.vehicles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VehicleCell", for: indexPath) as? VehicleCell else {
            return UICollectionViewCell()
        }
        cell.isItemSelected = indexPath.item == selectedIndexPath
        cell.vehicles = viewModel.vehicles[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint(indexPath.item)
        handleVehicleSelection(collectionView: collectionView, indexPath: indexPath)
    }
    
}

extension VehicleVC {
    
    fileprivate func updateConfigurations() {
        
        let nib = UINib(nibName: "VehicleCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "VehicleCell")
        
        updateEvents()
        self.viewModel.getVehicleData(distance: planet?.distance)
        
        
        guard let planet else { return }
        planetName.text = planet.name
        planetImage.image = UIImage(named: planet.name?.lowercased() ?? "no_image")
    }
    
    
    private func updateEvents(){
        self.viewModel.eventHandler = { [weak self] event in
            guard let self else {
                return
            }
            switch event {
            case .loading :
                debugPrint("Data Started Loading.")
            case .dataLoaded :
                debugPrint("Data Loaded Successfully")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .error(let err) :
                debugPrint("Error Occured", err)
            }
        }
    }
    
    fileprivate func handleVehicleSelection(collectionView : UICollectionView, indexPath : IndexPath) {
        
        let title = "Finding Falcone"
        let message = "Are you sure you want to select this vehicle to search for Princess"
        CommonFunction.shared.showAlert(title: title, message: message) { [weak self] success in
            if success {
                self?.selectedIndexPath = indexPath.item
                collectionView.reloadData()
            } else {
                self?.animateCell(collectionView.cellForItem(at: indexPath) as? VehicleCell ?? VehicleCell() )
            }
        }
    }
    
    func animateCell(_ cell: VehicleCell) {
        UIView.animate(withDuration: 2.0, animations: {
            // Animation 1: Rotate the image 180 degrees
            cell.vehicleImage.transform = CGAffineTransform(rotationAngle: .pi)
        }) { (completed) in
            if completed {
                // Animation 1 completed
                
                UIView.animate(withDuration: 2.0, animations: {
                    // Animation 2: Move the image to the center of the screen
                    cell.vehicleImage.center = CGPoint(x: self.view.frame.width/2 , y: self.view.frame.height/2 )
                }) { (completed) in
                    if completed {
                        // Animation 2 completed
                        
                        UIView.animate(withDuration: 2.0, animations: {
                            // Animation 3: Rotate the image 90 degrees to the left
                            cell.vehicleImage.transform = CGAffineTransform(rotationAngle: -.pi / 4.0)
                        }) { (completed) in
                            if completed {
                                // Animation 3 completed
                                
                                UIView.animate(withDuration: 2.0, animations: {
                                    // Animation 4: Move the image out of the screen
                                    cell.vehicleImage.center = CGPoint(x: -self.planetImage.frame.size.width, y: self.planetImage.center.y)
                                }) { (completed) in
                                    if completed {
                                        // Animation 4 completed
                                        self.navigationController?.popViewController(animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


