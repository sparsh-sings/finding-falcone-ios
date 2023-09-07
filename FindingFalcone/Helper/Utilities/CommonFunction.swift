//
//  CommonFunction.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 07/09/23.
//

import UIKit

class CommonFunction {
    
    static let shared = CommonFunction()

    func showAlert(title: String?, message: String?, completionHandler: @escaping (Bool) -> Void) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "YES", style: .default) { (_) in
                completionHandler(true)
            }
            let cancelAction = UIAlertAction(title: "NO", style: .cancel) { (_) in
                completionHandler(false)
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            if let topViewController = windowScene.windows.first?.rootViewController {
                topViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}
