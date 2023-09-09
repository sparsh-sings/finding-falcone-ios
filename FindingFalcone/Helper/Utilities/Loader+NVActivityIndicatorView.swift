//
//  Loader+NVActivityIndicatorView.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 09/09/23.
//

import UIKit
import NVActivityIndicatorView

class UILoader {
    
    static let shared = UILoader()
    
    private var activityIndicatorView: NVActivityIndicatorView?
    
    func initializeActivityIndicator(in view: UIView) {
           let frame = CGRect(x: 0, y: 0, width: 80, height: 80)
           let type: NVActivityIndicatorType = .circleStrokeSpin
           let color = UIColor.black
           let padding: CGFloat = 0

           activityIndicatorView = NVActivityIndicatorView(frame: frame, type: type, color: color, padding: padding)
           activityIndicatorView?.center = view.center
           view.addSubview(activityIndicatorView!)
       }

       func startAnimating() {
           activityIndicatorView?.startAnimating()
       }

       func stopAnimating() {
           activityIndicatorView?.stopAnimating()
       }

       var isAnimating: Bool {
           return activityIndicatorView?.isAnimating ?? false
       }
  
    
}
