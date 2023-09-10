//
//  ConfirmationVC.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 09/09/23.
//

import UIKit

class ConfirmationVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ConfirmationViewModel()
    var confirmList : [String: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateConfiguration()
       
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if sender.tag == 0 {
            self.navigationController?.popViewController(animated: true)
        } else {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "ResultVC") as? ResultVC else {
                return
            }
            vc.data = [
                Constant.token : viewModel.token,
                Constant.planets : viewModel.planetNames,
                Constant.vehicles : viewModel.vehicleNames
            ]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
   

}

extension ConfirmationVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.planetNames.count == viewModel.vehicleNames.count {
            return viewModel.planetNames.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmationCell") as? ConfirmationCell else {
            return UITableViewCell()
        }
        cell.planetName = viewModel.planetNames[indexPath.row]
        cell.vehicleName = viewModel.vehicleNames[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}

extension ConfirmationVC {
    
    fileprivate func updateConfiguration() {
        let nib = UINib(nibName: "ConfirmationCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ConfirmationCell")
        
        eventHandler()
        viewModel.getToken()
        viewModel.extractPlanetShips(data: confirmList)
       
    }
    
    fileprivate func eventHandler() {
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
                    print(self.viewModel.token)
                    self.tableView.reloadData()
                }
            case .error(let err) :
                CommonFunction.shared.showApiError(err, viewController: self)
            }
        }
        
    }
    
}
