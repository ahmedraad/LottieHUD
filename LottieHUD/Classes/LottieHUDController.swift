//
//  LottieHUDController.swift
//  LottieHUD
//
//  Created by Ahmed Raad on 4/8/19.
//  Copyright © 2019 Ahmed Raad. All rights reserved.
//

import Foundation

class LottieHUDController: UIViewController {
    
    var statusBarStyle = UIStatusBarStyle.default
    var statusBarHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let topVC = UIApplication.shared.topController() else { return statusBarStyle }
        if !topVC.isKind(of: LottieHUDController.self) {
            statusBarStyle = topVC.preferredStatusBarStyle
        }
        return statusBarStyle
    }
    
    override var prefersStatusBarHidden: Bool {
        guard let topVC = UIApplication.shared.topController() else { return statusBarHidden }
        if !topVC.isKind(of: LottieHUDController.self) {
            statusBarHidden = topVC.prefersStatusBarHidden
        }
        return statusBarHidden
    }
}
