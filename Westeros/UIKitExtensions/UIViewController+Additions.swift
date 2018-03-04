//
//  UIViewController+Additions.swift
//  Westeros
//
//  Created by Cristian Blazquez Bustos on 13/2/18.
//  Copyright © 2018 Cbb. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
