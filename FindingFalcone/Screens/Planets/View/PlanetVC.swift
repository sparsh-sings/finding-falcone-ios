//
//  PlanetVC.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 06/09/23.
//

import UIKit

class PlanetVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var letsGoButton: UIButton!
    
    var viewModel = PlanetViewModel()
    var loader = UILoader.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateConfigurations()
    }
    
    deinit {
        debugPrint("PlanetVC was deinitilized.")
    }
    
    @IBAction func letsGoButtonAction(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ConfirmationVC") as? ConfirmationVC else { return }
        vc.confirmList = viewModel.mapdata()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PlanetVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.planets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetCell", for: indexPath) as? PlanetCell else {
            return UICollectionViewCell()
        }
        cell.vehicles = viewModel.indexWithVehicle[indexPath.item] ?? ""
        let planet = viewModel.planets[indexPath.item]
        cell.planets = planet
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleVC") as? VehicleVC else { return }
        vc.delegate = self
        vc.vehicleUsed = viewModel.indexWithVehicle
        vc.planetIndex = indexPath.row
        vc.planet = viewModel.planets[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = (collectionViewWidth - 10) / 2
        let cellHeight: CGFloat = 260.0
        return CGSize(width: cellWidth, height: cellHeight)
    }

}

extension PlanetVC {
    
    func updateConfigurations() {
        
        loader.initializeActivityIndicator(in: self.view)
        
        let nib = UINib(nibName: "PlanetCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "PlanetCell")
        
        updateEvents()
        viewModel.getPlanetList()
        
    }
    
    func updateEvents(){
            self.viewModel.eventHandler = { [weak self] event in
                guard let self else {
                    return
                }
                switch event {
                case .loading :
                    loader.startAnimating()
                case .dataLoaded :
                    debugPrint("Data Loaded Successfully")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                        self.collectionView.reloadData()
                        self.loader.stopAnimating()
                    }
                case .error(let err) :
                    debugPrint("Error Occured", err)
                }
            }
        }
}

extension PlanetVC : VehicleSelectedProtocol {
    
    func didSelectVehicle(planetIndex: Int, vehicleName: String) {
        viewModel.indexWithVehicle.updateValue(vehicleName, forKey: planetIndex)
        collectionView.reloadData()
    }
    
}
