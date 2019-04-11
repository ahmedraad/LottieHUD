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
        let appearnce = LottieHUDAppearance.init(source: .name("animation"))
        appearnce.overlaySize = .full
        appearnce.backgroundStyle = .black
        appearnce.corner = 15
        LottieHUD.show(with: appearnce)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            LottieHUD.hide({
                LottieHUD.show()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    LottieHUD.hide()
                }
            })
        }
    }
}

