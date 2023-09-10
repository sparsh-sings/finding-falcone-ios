//
//  ResultVC.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 09/09/23.
//

import UIKit
import Lottie

class ResultVC: UIViewController {
    
    @IBOutlet weak var annimationView: UIView!
    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    let viewModel = ResultViewModel()
    var loader = UILoader.shared
    
    var data : [String: Any]? {
        didSet {
            viewModel.getResultStatus(token: data?[Constant.token] as! String, planet_name: data?[Constant.planets] as! [String], vehicle_names: data?[Constant.vehicles] as! [String])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler()
        
    }
    
    

}

extension ResultVC {
    
    fileprivate func eventHandler() {
        self.viewModel.eventHandler = { [weak self] event in
            guard let self else {
                return
            }
            switch event {
            case .loading :
                DispatchQueue.main.async {
                    self.loader.startAnimating()
                    self.statusLabel.text = "Loading Result"
                }
            case .responseLoaded(let result) :
                debugPrint("Data Loaded Successfully")
                DispatchQueue.main.async {
                    self.viewModel.showAnnimation(view: self.annimationView, type: result ?? .lose) { result in
                        self.updateData(result: result)
                        self.viewModel.finalMessage(result, self)
                        self.loader.startAnimating()
                    }
                }
            case .error(let err) :
                CommonFunction.shared.showApiError(err, viewController: self)
            }
        }
        
    }
    
    private func updateData(result : ResultType) {
    
        if result == .win {
            statusLabel.text = "Congratulations, Queen Al Falcone was found at " + (viewModel.result?.planetName ?? "")
            planetImage.image = UIImage(named: viewModel.result?.planetName?.lowercased() ?? "")
        } else {
            
            planetImage.image = UIImage(named: "gameOver")
            
            if let error = viewModel.result?.error {
                statusLabel.text = "Error - " + error
            } else if let status = viewModel.result?.status {
                statusLabel.text = "Sorry, Could Not Find Queen Al Falcone."
            } else {
                statusLabel.text = "Error 404 : Result not found, please try again later."
            }
        }
        
    }
    
}
