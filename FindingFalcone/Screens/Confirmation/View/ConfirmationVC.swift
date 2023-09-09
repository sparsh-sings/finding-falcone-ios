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
    var confirmList : [String: Any]?
    
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
            vc.token = viewModel.token
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
   

}

extension ConfirmationVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10//confirmList?.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmationCell") as? ConfirmationCell else {
            return UITableViewCell()
        }
        cell.planetName = "donlon"
        cell.vehicleName = "spacepod"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension ConfirmationVC {
    
    fileprivate func updateConfiguration() {
        let nib = UINib(nibName: "ConfirmationCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ConfirmationCell")
        
        eventHandler()
        viewModel.getToken()
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
                }
            case .error(let err) :
                debugPrint("Error Occured", err)
            }
        }
        
    }
    
}
