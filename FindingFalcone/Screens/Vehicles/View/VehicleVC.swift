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
    var planetIndex: Int?
    
    var vehicleUsed : [Int: String]?
    
    weak var delegate : VehicleSelectedProtocol?
    
    var viewModel = VehicleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateConfigurations()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        debugPrint("The View Controller is Deinitilized.")
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
        self.viewModel.getVehicleData(distance: planet?.distance, usedRocketDict: vehicleUsed ?? [:])
        
        
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
                CommonFunction.shared.showApiError(err, viewController: self)
            }
        }
    }
    
    fileprivate func handleVehicleSelection(collectionView : UICollectionView, indexPath : IndexPath) {
        
        let title = "Finding Falcone"
        let message = "Are you sure you want to select this vehicle to search for Princess"
        CommonFunction.shared.showAlert(title: title, message: message) { [weak self] success in
            if success {
                self?.animateCell(collectionView.cellForItem(at: indexPath) as? VehicleCell ?? VehicleCell() )
                self?.selectedIndexPath = indexPath.item
            }
        }
    }
    
    func animateCell(_ cell: VehicleCell) {
        UIView.animate(withDuration: 2.0, animations: {
            cell.vehicleImage.center = CGPoint(x: cell.vehicleImage.center.x, y: -self.view.frame.size.height)
        }) { (completed) in
            if completed {
                self.delegate?.didSelectVehicle(planetIndex: self.planetIndex ?? 0, vehicleName: cell.vehicleName.text ?? "")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}


