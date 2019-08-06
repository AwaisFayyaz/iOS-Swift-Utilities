//
//  UINavigationController.swift
//  AccessAgriculture
//
//  Created by Bugdev Studio on 30/01/2019.
//  Copyright © 2019 bugdev. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func makeTransparent() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }
}
