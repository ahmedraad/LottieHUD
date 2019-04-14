//
//  ViewController.swift
//  Example
//
//  Created by Ahmed Raad on 4/9/19.
//  Copyright © 2019 Ahmed Raad. All rights reserved.
//

import UIKit
import LottieHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LottieHUD.shared.appearance.source = .name("animation")
        LottieHUD.shared.appearance.backgroundStyle = .black
        LottieHUD.shared.appearance.overlaySize = .full
        LottieHUD.shared.appearance.corner = 0
        LottieHUD.shared.appearance.presentDuration = 0.3
    }

    @IBAction func show(_ sender: Any) {
        let appearnce = LottieHUDAppearance.init(source: .name("loading"))
        appearnce.overlaySize = .custom(CGSize(width: 200, height: 200))
        appearnce.backgroundStyle = .black
        appearnce.presentDuration = 0.5
        appearnce.corner = 15
        LottieHUD.show()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            LottieHUD.hide({
                LottieHUD.show(with: appearnce)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    LottieHUD.hide()
                }
            })
        }
    }
}

