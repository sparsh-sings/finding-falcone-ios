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
    
    func showAlertWithOkAction(title: String, message: String, dismissHandler: ((_ buttonIndex: Int) -> Void)?) {
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                guard dismissHandler != nil else {
                    return
                }
                dismissHandler!(1)
            })
            alertController.addAction(action)
            
            if let topViewController = windowScene.windows.first?.rootViewController {
                topViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func showNoInternetAlert() {
        let appName = Constant.App_Name
        let message = "Looks like you are not connected to internet, please check your internet connection and try again"
        
        showAlertWithOkAction(title: appName, message: message) { buttonIndex in
            debugPrint("No Internt alert is dismissed.")
        }
        
    }
    
    func showApiError(_ message : String?, viewController self : UIViewController) {
        DispatchQueue.main.async {
            CommonFunction.shared.showAlertWithOkAction(title: Constant.App_Name, message: message ?? "API Error Occured.") { buttonIndex in
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func countOccurrences(dictionary: [Int: String]) -> [String: Int] {
        var result: [String: Int] = [:]

        for (_, value) in dictionary {
            if let count = result[value] {
                result[value] = count + 1
            } else {
                result[value] = 1
            }
        }
        return result
    }
    
}
