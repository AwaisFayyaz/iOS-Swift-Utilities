//
//  Font.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/23/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

typealias MainFont = Font.HelveticaNeue

enum Font {
  enum HelveticaNeue: String {
    case ultraLightItalic = "UltraLightItalic"
    case medium = "Medium"
    case mediumItalic = "MediumItalic"
    case ultraLight = "UltraLight"
    case italic = "Italic"
    case light = "Light"
    case thinItalic = "ThinItalic"
    case lightItalic = "LightItalic"
    case bold = "Bold"
    case thin = "Thin"
    case condensedBlack = "CondensedBlack"
    case condensedBold = "CondensedBold"
    case boldItalic = "BoldItalic"
    
    func with(size: CGFloat) -> UIFont {
      return UIFont(name: "HelveticaNeue-\(rawValue)", size: size)!
    }
  }
}

//
//  Font.swift
//  AccessAgriculture
//
//  Created by Bugdev Studio on 12/02/2019.
//  Copyright © 2019 bugdev. All rights reserved.
//

import Foundation
import UIKit

struct Font {
    
    enum FontName: String {
        case MontserratBold             = "Montserrat-Bold"
        case MontserratRegular          = "Montserrat-Regular"
    }
    enum StandardSize: Double {
        case h1 = 20.0
        case h2 = 18.0
        case h3 = 16.0
        case h4 = 14.0
        case h5 = 12.0
        case h6 = 10.0
    }
    
    enum FontType {
        case installed(FontName)
        case custom(String)
        case system
        case systemBold
        case systemItatic
        case systemWeighted(weight: Double)
        case monoSpacedDigit(size: Double, weight: Double)
    }
    enum FontSize {
        case standard(StandardSize)
        case custom(Double)
        var value: Double {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }
    
    
    var type: FontType
    var size: FontSize
    init(_ type: FontType, size: FontSize) {
        self.type = type
        self.size = size
    }
}

extension Font {
    var instance: UIFont {
        
        var instanceFont: UIFont!
        switch type {
        case .custom(let fontName):
            guard let font =  UIFont(name: fontName, size: CGFloat(size.value)) else {
                fatalError("\(fontName) font is not installed, make sure it is added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .installed(let fontName):
            guard let font =  UIFont(name: fontName.rawValue, size: CGFloat(size.value)) else {
                fatalError("\(fontName.rawValue) font is not installed, make sure it is added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .system:
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value))
        case .systemBold:
            instanceFont = UIFont.boldSystemFont(ofSize: CGFloat(size.value))
        case .systemItatic:
            instanceFont = UIFont.italicSystemFont(ofSize: CGFloat(size.value))
        case .systemWeighted(let weight):
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value),
                                             weight: UIFont.Weight(rawValue: CGFloat(weight)))
        case .monoSpacedDigit(let size, let weight):
            instanceFont = UIFont.monospacedDigitSystemFont(ofSize: CGFloat(size),
                                                            weight: UIFont.Weight(rawValue: CGFloat(weight)))
        }
        return instanceFont
    }
}

