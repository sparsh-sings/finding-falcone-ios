//
//  PlanetVC.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 06/09/23.
//

import UIKit

class PlanetVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = PlanetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateConfigurations()
    }
    
}

extension PlanetVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell") as? PlanetCell else {
            return UITableViewCell()
        }
        let planet = viewModel.planets[indexPath.row]
        cell.planets = planet
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "VehicleVC") as? VehicleVC else { return }
        vc.planet = viewModel.planets[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension PlanetVC {
    
    func updateConfigurations() {
        let nib = UINib(nibName: "PlanetCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PlanetCell")
        
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
                        self.tableView.reloadData()
                    }
                case .error(let err) :
                    debugPrint("Error Occured", err)
                }
            }
        }
}

