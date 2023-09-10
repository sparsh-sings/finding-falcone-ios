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
    
    @IBAction func helpButtonAction(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "InstructionVC") as? InstructionVC else {
            return
        }
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
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
        
        if viewModel.mapdata().count > 3 {
            
            let message = "You have selected all the vehicles for this journey, please click on Let's Go to get the result."
            CommonFunction.shared.showAlertWithOkAction(title: Constant.App_Name, message: message) { buttonIndex in
                debugPrint("Ok Button was tapped.")
            }
            
        } else {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleVC") as? VehicleVC else { return }
            vc.delegate = self
            vc.vehicleUsed = viewModel.indexWithVehicle
            vc.planetIndex = indexPath.row
            vc.planet = viewModel.planets[indexPath.item]
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
        
        updateButtonStatus()
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
                    CommonFunction.shared.showApiError(err, viewController: self)
                }
            }
        }
}

extension PlanetVC : VehicleSelectedProtocol {
    
    func didSelectVehicle(planetIndex: Int, vehicleName: String) {
        viewModel.indexWithVehicle.updateValue(vehicleName, forKey: planetIndex)
        updateButtonStatus()
        collectionView.reloadData()
    }
    
    fileprivate func updateButtonStatus() {
        
        let mappedDataCount = viewModel.mapdata().count
        
        if mappedDataCount == 4 {
            letsGoButton.isUserInteractionEnabled = true
            letsGoButton.backgroundColor = UIColor.systemTeal
        } else {
            letsGoButton.isUserInteractionEnabled = false
            letsGoButton.backgroundColor = UIColor.systemGray
        }
        
    }
    
}
