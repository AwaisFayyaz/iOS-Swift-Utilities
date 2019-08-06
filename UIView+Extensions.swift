//
//  UIView+Extensions.swift
//  BlindTunes
//
//  Created by BugDev Studios on 23/10/2018.
//  Copyright © 2018 BugDev Studios. All rights reserved.
//

import UIKit
extension UIView {
  
  func show(){
    DispatchQueue.main.async {
      self.isHidden = false
    }
  }
  
  func hide(){
    DispatchQueue.main.async {
      self.isHidden = true
    }
  }
  
  func fadeIn(){
    
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.3, animations: {
        self.alpha = 1
        self.layoutIfNeeded()
      })
    }
    
  }
  
  
  func fadeOut(){
    
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.3, animations: {
        self.alpha = 0
        self.layoutIfNeeded()
      })
    }
    
  }
  

  
  @IBInspectable var BorderColor: UIColor {
    set {
      layer.borderColor = newValue.cgColor
    }
    get {
      return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
    }
  }
  
  @IBInspectable var BorderWidth: CGFloat {
    set {
      layer.borderWidth = newValue
    }
    get {
      return layer.borderWidth
    }
  }
}
