//
//  UIImage+Extensions.swift
//  FindingFalcone
//
//  Created by Sparsh Singh on 06/09/23.
//

import UIKit

@IBDesignable class SSImage: UIImageView {
    private var _round = false
    private var _borderColor = UIColor.clear
    private var _borderWidth: CGFloat = 0
    
    private var _cornerRadius: CGFloat = 0

    @IBInspectable var round: Bool {
        set {
            _round = newValue
            makeRound()
        }
        get {
            return self._round
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        set {
            _borderColor = newValue
            setBorderColor()
        }
        get {
            return self._borderColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        set {
            _borderWidth = newValue
            setBorderWidth()
        }
        get {
            return self._borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
           set {
               _cornerRadius = newValue
               setCornerRadiou()
           }
           get {
               return self._cornerRadius
           }
       }

    override internal var frame: CGRect {
        set {
            super.frame = newValue
            makeRound()
        }
        get {
            return super.frame
        }
    }

    private func makeRound() {
        if self.round {
            self.clipsToBounds = true
            self.layer.cornerRadius = (self.frame.width + self.frame.height) / 4
        } else {
            self.layer.cornerRadius = 0
        }
    }

    private func setBorderColor() {
        self.layer.borderColor = self._borderColor.cgColor
    }

    private func setBorderWidth() {
        self.layer.borderWidth = self._borderWidth
    }
    
    private func setCornerRadiou() {
        self.layer.cornerRadius = self._cornerRadius
    }
}
