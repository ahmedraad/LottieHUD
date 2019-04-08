//
//  Extensions.swift
//  LottieHUD
//
//  Created by Ahmed Raad on 4/8/19.
//  Copyright © 2019 Ahmed Raad. All rights reserved.
//

import Foundation

extension UIApplication {
    func topController(_ base: UIViewController? = nil) -> UIViewController? {
        let base = base ?? keyWindow?.rootViewController
        if let top = (base as? UINavigationController)?.topViewController {
            return topController(top)
        }
        if let selected = (base as? UITabBarController)?.selectedViewController {
            return topController(selected)
        }
        if let presented = base?.presentedViewController {
            return topController(presented)
        }
        return base
    }
}

extension NSLayoutConstraint {
    convenience init(item viewToAdd: Any, attribute ofViewToAdd: NSLayoutConstraint.Attribute, relatedBy relation: NSLayoutConstraint.Relation = .equal, toItem addedOn: Any? = nil, attribute ofAddedOn: NSLayoutConstraint.Attribute? = nil, constant: CGFloat = 0) {
        self.init(item: viewToAdd, attribute: ofViewToAdd, relatedBy: relation, toItem: addedOn, attribute: ofAddedOn ?? ofViewToAdd, multiplier: 1.0, constant: constant)
    }
}
