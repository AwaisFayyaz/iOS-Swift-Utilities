//
//  UIViewController+Extensions.swift
//  BlindTunes
//
//  Created by BugDev Studios on 23/10/2018.
//  Copyright © 2018 BugDev Studios. All rights reserved.
//

import UIKit
import Lottie
extension UIViewController {
  func showAlert(title :String?, message :String?, okButtonTitle :String?, callback: ( ()->() )? = nil) {
    
    DispatchQueue.main.async {
      
      let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let ok = UIAlertAction(title: okButtonTitle, style: .default, handler: {(action) in
        alertController.dismiss(animated: true, completion: nil)
        callback?()
      })
      alertController.addAction(ok)
      
      self.present(alertController, animated: true, completion: nil)
      
    }
    
  }
  
  func showToast(message : String, duration: TimeInterval = 1) {
    guard GLOBALSETTINGS.debugPrint else {
      return
    }
    DispatchQueue.main.async {
      let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height-100, width: 240, height: 44))
      toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
      toastLabel.textColor = UIColor.white
      toastLabel.textAlignment = .center;
      toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
      toastLabel.text = message
      toastLabel.alpha = 1.0
      toastLabel.layer.cornerRadius = 10;
      toastLabel.clipsToBounds  =  true
      self.view.addSubview(toastLabel)
      UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
        toastLabel.alpha = 0.0
      }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
      })
    }
    
  }
  
  func hideNavigationbar() {
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  func showNavigationBar() {
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  
  /// sets itself(the view controller) to be delegate of ProtocolXibNowPlaying and plays gif inside xibViews image
  ///
  /// - Parameter xibView:The passed xib view to show gif in and set delegate
  func setupXibNowPlaying(xibView: XibNowPlayingView) {
    
    xibView.delegate? = self as! ProtocolXibNowPlaying
    guard let imageViewPlayingGif = xibView.imageViewPlayingGif else { return }
    imageViewPlayingGif.animate(withGIFNamed: "music")
    imageViewPlayingGif.stopAnimatingGIF()
    
  }
  

  func add(_ child: UIViewController, frame: CGRect? = nil) {
    
    addChildViewController(child)
    
    if let frame = frame {
      child.view.frame = frame
    }
    
    view.addSubview(child.view)
    
    child.didMove(toParentViewController: self)
  }
  
  func remove() {
    
    UIView.animate(withDuration: 0.5) {
      
      self.willMove(toParentViewController: nil)
      self.removeFromParentViewController()
      self.view.removeFromSuperview()
      
    }
    
    
  }


  func showViewLotAnimation(_ viewAnimation: LOTAnimationView) {
    
    DispatchQueue.main.async {
      
      viewAnimation.frame = CGRect.init(x: 0, y: 0, width: 200, height: 200)
      viewAnimation.center = self.view.center
      self.view.addSubview(viewAnimation)
      viewAnimation.play()
      
    }
    
    
  }
  
  func hideViewLotAnimations(_ lotAnimationView: LOTAnimationView){
    DispatchQueue.main.async {
      for view in self.view.subviews {
        if view is LOTAnimationView {
          view.removeFromSuperview()
        }
      }
    }
    
  }
  
  func pop() {
    DispatchQueue.main.async {
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  func push(_ viewController: UIViewController) {
    DispatchQueue.main.async {
      self.navigationController?.push(viewController )
    }
  }
}
extension LOTAnimationView {
  
  static var loader = GLOBALS.viewsLotAnimations.loader
  static var tickSuccess = GLOBALS.viewsLotAnimations.tickSuccess
  
}
