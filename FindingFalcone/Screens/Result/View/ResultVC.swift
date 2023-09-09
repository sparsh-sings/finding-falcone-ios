//
//  ResultVC.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 09/09/23.
//

import UIKit

class ResultVC: UIViewController {
    
    let viewModel = ResultViewModel()
    
    var token : String? {
        didSet {
            viewModel.getResultStatus(token: token!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    

}
