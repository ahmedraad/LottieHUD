//
//  LottieHUD.swift
//  LottieHUD
//
//  Created by Ahmed Raad on 12/17/17.
//  Copyright © 2017 Ahmed Raad. All rights reserved.
//

import Foundation
import Lottie
import UIKit

class LottieHUD {
    
    public var animationDuration: TimeInterval = 0.3
    public static var shadow: CGFloat = 0.7
    
    private var backgroundView: UIView = {
        let bg = UIView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.backgroundColor = UIColor.black.withAlphaComponent(shadow)
        bg.isUserInteractionEnabled = false
        bg.alpha = 0.0
        return bg
    }()
    
    public var contentMode: UIViewContentMode = .scaleAspectFit {
        didSet {
            self._lottie.contentMode = contentMode
        }
    }
    
    public var frame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200)
    
    private var _lottie: LOTAnimationView = {
        var lt = LOTAnimationView()
        lt.loopAnimation = true
        return lt
    }()
    
    init(_ name: String, loop: Bool = true) {
        self._lottie = LOTAnimationView(name: name)
        self._lottie.loopAnimation = loop
    }
    
    init(_ lottie: LOTAnimationView) {
        self._lottie = lottie
    }
    
    public func showHUD(with delay: TimeInterval = 0.0, loop: Bool = true) {
        _lottie.loopAnimation = loop
        createHUD(delay: delay)
    }
    
    public func stopHUD() {
        clearHUD()
    }
    
    private func createHUD(delay: TimeInterval = 0.0) {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow!.isUserInteractionEnabled = false
            self.backgroundView.addSubview(self._lottie)
            self._lottie.frame = self.frame
            
            self.keyWindow.view.addSubview(self.backgroundView)
            self.backgroundView.frame = self.keyWindow.view.bounds
            self._lottie.center = self.backgroundView.center
            
            UIView.animate(withDuration: self.animationDuration, delay: delay, options: .curveEaseIn, animations: {
                self.backgroundView.alpha = 1.0
            }, completion: nil)
            
            self._lottie.play(completion: { _ in
                self.clearHUD()
            })
        }
    }
    
    private func clearHUD() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseIn, animations: {
                self.backgroundView.alpha = 0.0
            }) { finished in
                UIApplication.shared.keyWindow!.isUserInteractionEnabled = true
                self.backgroundView.removeFromSuperview()
                self._lottie.stop()
            }
        }
    }
    
    private var keyWindow: UIViewController {
        return UIApplication.topViewController()!
    }
    
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
