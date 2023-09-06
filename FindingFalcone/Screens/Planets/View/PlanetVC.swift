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

extension PlanetVC {
    
    func updateConfigurations() {
        let nib = UINib(nibName: "PlanetCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PlanetCell")
        
        viewModel.getPlanetList()
        UpdateEvents()
    }
    
    func UpdateEvents(){
            self.viewModel.eventHandler = { [weak self] event in
                guard let self else {
                    return
                }
                switch event {
                case .loading :
                    debugPrint("loading")
                case .dataLoading :
                    debugPrint("Data is loading")
                    debugPrint(self.viewModel.planets.count)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .error(let err) :
                    debugPrint("Error occured", err)
                }
            }
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
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
