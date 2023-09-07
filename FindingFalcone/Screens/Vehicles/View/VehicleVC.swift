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
    
    var viewModel = VehicleViewModel()
    var newVehicleData : Vehicles = []
    
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
        return newVehicleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VehicleCell", for: indexPath) as? VehicleCell else {
            return UICollectionViewCell()
        }
        cell.vehicles = newVehicleData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint(indexPath.item)
    }
    
}

extension VehicleVC {
    
    fileprivate func updateConfigurations() {
        
        let nib = UINib(nibName: "VehicleCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "VehicleCell")
        
        updateEvents()
        self.viewModel.getVehicleData()
        
        
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
                newVehicleData = viewModel.vehicles.filter { ($0.maxDistance ?? 0) >= self.planet?.distance ?? 0 }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .error(let err) :
                debugPrint("Error Occured", err)
            }
        }
    }
    
}
