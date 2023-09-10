//
//  StartVC.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 10/09/23.
//

import UIKit

class StartVC: UIViewController {
    
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func startButtonAction(_ sender: UIButton) {
        if Reach.isConnectedToNetwork() {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "PlanetVC") as? PlanetVC else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            CommonFunction.shared.showNoInternetAlert()
        }
    }
    

}
