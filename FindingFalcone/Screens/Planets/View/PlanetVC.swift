//
//  PlanetVC.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 06/09/23.
//

import UIKit

class PlanetVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = PlanetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateConfigurations()
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
        let planet = viewModel.planets[indexPath.item]
        cell.planets = planet
        return cell
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

