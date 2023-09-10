//
//  ResultViewModel.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 09/09/23.
//

import UIKit
import Lottie

class ResultViewModel {
    
    var result : Status?
    let lottieAnimationView = LottieAnimationView()
    var eventHandler : ((_ events : Events) -> Void)?
    
    func getResultStatus(token: String, planet_name: [String], vehicle_names: [String]) {
        
        self.eventHandler?(.loading)
        
        let param : [String : Any] = [
            "token": token,
            "planet_names": planet_name,
            "vehicle_names": vehicle_names
        ]
        
        NetworkClass.shared.apiRequest(url: Constant.base_url + "find", params: param, method: .post, responseObject: Status.self, callBack: Callback(onSuccess: { response in
            self.displayResult(response: response)
        }, onFailure: { error in
            debugPrint(error)
            self.eventHandler?(.error(error))
        }))
        
    }
    
    func displayResult(response : Status) {
        
        self.result = response
        
        if response.status == "success" {
            self.eventHandler?(.responseLoaded(.win))
        } else {
            self.eventHandler?(.responseLoaded(.lose))
        }
    }
    
    func finalMessage(_ result : ResultType, _ viewControlelr : UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            var message = ""
            
            if result == .win {
                message = "You Won, Let's Play this again."
            } else {
                message = "There is always a next time."
            }
            
            CommonFunction.shared.showAlertWithOkAction(title: "Finding Falcone", message: message) { buttonIndex in
                viewControlelr.navigationController?.popToRootViewController(animated: true)
            }
            
        }
    }
    
}

extension ResultViewModel {
    
    enum Events {
        case loading
        case responseLoaded(ResultType?)
        case error(String?)
    }
    
}

// Lottie Annimations

extension ResultViewModel {
    
    func showAnnimation(view: UIView, type : ResultType, completion: @escaping(ResultType) -> Void) {
        view.addSubview(lottieAnimationView)
        if type == .win {
            lottieAnimationView.animation = LottieAnimation.named("winning")
            completion(.win)
        } else {
            lottieAnimationView.animation = LottieAnimation.named("losing")
            completion(.lose)
        }
        lottieAnimationView.frame = view.bounds
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.play()
    }
    
}

enum ResultType: String {
    case win = "winning"
    case lose = "losing"
}


