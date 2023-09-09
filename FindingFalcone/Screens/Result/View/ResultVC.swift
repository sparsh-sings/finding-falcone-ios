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
    
   
    
    let viewModel = ResultViewModel()
    
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
                debugPrint("Data Started Loading.")
            case .responseLoaded(let result) :
                debugPrint("Data Loaded Successfully")
                DispatchQueue.main.async {
                    self.viewModel.showAnnimation(view: self.annimationView, type: result ?? .lose) {
                        print("Something Happened")
                    }
                }
            case .error(let err) :
                debugPrint("Error Occured", err)
            }
        }
        
    }
    
}
