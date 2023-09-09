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
    var completedPlanetIndex : [Int : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateConfigurations()
    }
    
    @IBAction func letsGoButtonAction(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ConfirmationVC") as? ConfirmationVC else { return }
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
        cell.vehicles = completedPlanetIndex[indexPath.item] ?? ""
        let planet = viewModel.planets[indexPath.item]
        cell.planets = planet
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleVC") as? VehicleVC else { return }
        vc.delegate = self
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
}

extension PlanetVC : VehicleSelectedProtocol {
    
    func didSelectVehicle(planetIndex: Int, vehicleName: String) {
        completedPlanetIndex.updateValue(vehicleName, forKey: planetIndex)
//        someArray.map {($0.key, $0.value)}
        collectionView.reloadData()
    }
    
}
