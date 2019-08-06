//
//  Popups.swift
//  BlindTunes
//
//  Created by BugDev Studios on 30/11/2018.
//  Copyright © 2018 BugDev Studios. All rights reserved.
//

import UIKit
import SwiftEntryKit

struct Popups {
  
  static func increaseLimitOrSubscrible(flagIncreaseLimit: Bool, completion: @escaping callBackPopupPurchase ) {
    
    var titleToUse = PromptStrings.inAppPurchase.titleIncreaseLimit
    var textTouse = PromptStrings.inAppPurchase.textIncreaseLimit
    
    if !flagIncreaseLimit {
      //subscription
      titleToUse = PromptStrings.inAppPurchase.TitleSubscribe
      textTouse = PromptStrings.inAppPurchase.textBySubscribing
      
    }
    
    let headingFont = UIFont.boldSystemFont(ofSize: 25)
    let textFont = UIFont.systemFont(ofSize: 20)
    
    let title = EKProperty.LabelContent(text: titleToUse, style: .init(font: headingFont, color: .black, alignment: .center))
    let description = EKProperty.LabelContent(text: textTouse , style: .init(font: textFont, color: .black, alignment: .center))
    
    let image = EKProperty.ImageContent(imageName: "Avatar_Gray", size: CGSize(width: 50, height: 50), contentMode: .scaleAspectFit)
    let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
    
    // Generate buttons content
    let buttonFont = textFont
    
    // Close button
    let closeButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: UIColor.darkGray)
    let closeButtonLabel = EKProperty.LabelContent(text: "NOT NOW", style: closeButtonLabelStyle)
    let closeButton = EKProperty.ButtonContent(label: closeButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  UIColor.white) {
      SwiftEntryKit.dismiss()
      completion(false)
      
    }
    
    // Ok Button
    let okButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: EKColor.Teal.a600)
    let okButtonLabel = EKProperty.LabelContent(text: "YES", style: okButtonLabelStyle)
    let okButton = EKProperty.ButtonContent(label: okButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor.Teal.a600.withAlphaComponent(0.05)) {
      SwiftEntryKit.dismiss()
      completion(true)
    }
    
    let buttonsBarContent = EKProperty.ButtonBarContent(with: okButton, closeButton, separatorColor: EKColor.Gray.light, expandAnimatedly: true)
    
    let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, buttonBarContent: buttonsBarContent)
    
    // Setup the view itself
    let contentView = EKAlertMessageView(with: alertMessage)
    
    let attribs = attributesForPopupConfirmIncreaseSongLimit()
    SwiftEntryKit.display(entry: contentView, using: attribs)
    
    
  }
  
  static func successOrFailure(messageType: EKMessageType, _ titleText: String?, _ descText: String,
                               flagShowIndefinitely: Bool = false, callback: @escaping () -> () = { } ) {
    
    let tick = UIImage.init(named: "ic_done_all_light_48pt")!
    var imageTouse = tick
    
    
    var attributes = EKAttributes.centerFloat
    attributes.displayDuration = flagShowIndefinitely ? EKAttributes.DisplayDuration.infinity : 3
    attributes.entryBackground = .gradient(gradient: .init(colors: [UIColor(rgb: 0xAAB7B8), UIColor(rgb:0x17202A)], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
    if messageType == .success {
      
    }else if messageType == .failure {
      attributes.entryBackground = .gradient(gradient: .init(colors: [UIColor.darkGray, UIColor.red], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
      let cross = UIImage.init(named: "ic_cross")!
      imageTouse = cross
      
    }else if messageType == .noResults {
      let icNoResults = UIImage.init(named: "ic-no-results")!
      imageTouse = icNoResults
      
    }
    
    
    let dimmedDarkBackground = UIColor(white: 50.0/255.0, alpha: 0.3)
    attributes.screenBackground = .color(color: dimmedDarkBackground)
    attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8))
    attributes.screenInteraction = .dismiss
    attributes.entryInteraction = .absorbTouches
    attributes.roundCorners = .all(radius: 8)
    //showCenterPopupMessage(attributes: attributes, title: titleText ?? "Alert" , description: descText, image: imageTouse)
    showCenterPopupMessage(attributes: attributes, title: titleText ?? "Alert", description: descText, image: imageTouse) {
      callback()
    }
    
  }
  
  typealias callBackPopupPurchase = ( Bool) -> ()
  
  private static func showCenterPopupMessage(attributes: EKAttributes, title: String, description: String, image: UIImage? = nil, callback: @escaping () -> () = {} ) {
    
    var themeImage: EKPopUpMessage.ThemeImage?
    
    if let image = image {
      themeImage = .init(image: .init(image: image, size: CGSize(width: 60, height: 60), contentMode: .scaleAspectFit))
    }
    
    let buttonBG = UIColor.white
    let titleColor  = UIColor.white
    let descriptionColor = UIColor.white
    let buttonTitleColor = UIColor.black
    
    let title = EKProperty.LabelContent(text: title, style: .init(font: MainFont.medium.with(size: 24), color: titleColor, alignment: .center))
    let description = EKProperty.LabelContent(text: description, style: .init(font: MainFont.light.with(size: 20), color: descriptionColor, alignment: .center))
    let button = EKProperty.ButtonContent(label: .init(text: "OK", style: .init(font: MainFont.bold.with(size: 20), color: buttonTitleColor)), backgroundColor: buttonBG, highlightedBackgroundColor: buttonTitleColor.withAlphaComponent(0.05))
    let message = EKPopUpMessage(themeImage: themeImage, title: title, description: description, button: button) {
      SwiftEntryKit.dismiss()
      callback()
    }
    
    
    let contentView = EKPopUpMessageView(with: message)
    SwiftEntryKit.display(entry: contentView, using: attributes)
    
  }
  
  private static func attributesForPopupConfirmIncreaseSongLimit() -> EKAttributes {
    
    var attributes = EKAttributes.init()
    attributes = .centerFloat
    attributes.windowLevel = .alerts
    attributes.hapticFeedbackType = .success
    attributes.screenInteraction = .absorbTouches
    attributes.entryInteraction = .absorbTouches
    attributes.scroll = .disabled
    attributes.screenBackground = .color(color: .dimmedLightBackground)
    attributes.entryBackground = .color(color: .white)
    attributes.entranceAnimation = .init(scale: .init(from: 0.9, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)), fade: .init(from: 0, to: 1, duration: 0.3))
    attributes.exitAnimation = .init(fade: .init(from: 1, to: 0, duration: 0.2))
    attributes.displayDuration = .infinity
    attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 5))
    let edge = EKAttributes.PositionConstraints.Edge.ratio(value: 0.6)
    attributes.positionConstraints.maxSize = .init(width: edge, height: edge)
    //    attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
    
    return attributes
  }

  static func bottomBarMessage(_ descText: String, type: EKMessageType, flagShowIndefinitely: Bool = false) {
    //    showEntryKitBanner(messageType: .info, titleText: nil, descText: descText, position: .bottom)
    
    let font = UIFont.boldSystemFont(ofSize: 18 )
    let style = EKProperty.LabelStyle(font: font, color: .white, alignment: .center)
    let labelContent = EKProperty.LabelContent(text: descText, style: style)
    
    let contentView = EKNoteMessageView(with: labelContent)
    
    var attributes = EKAttributes.init()
    var backgroundColor = UIColor.black
    
    if type == .failure { backgroundColor = UIColor.red }
    else if type == .success { backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)}
    attributes.entryBackground = .color(color: backgroundColor)
    attributes.displayDuration = flagShowIndefinitely ? EKAttributes.DisplayDuration.infinity : 3
    attributes.position = .bottom
    SwiftEntryKit.display(entry: contentView, using: attributes)
  }
}


enum EKMessageType {
  case success
  case failure
  case info
  case validationError
  case noResults
}

