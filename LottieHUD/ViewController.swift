//
//  ViewController.swift
//  LottieHUD
//
//  Created by Ahmed Raad on 1/14/18.
//  Copyright © 2018 Ahmed Raad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var hud = LottieHUD("veil")
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func showClick(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            hud.showHUD()
            Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(dismissHUD), userInfo: nil, repeats: false)
        case 2:
            LottieHUD("veil").showHUD(with: 2.0)
        case 3:
            // default is True
            hud.showHUD(loop: false)
        default:
            break
        }
    }
    
    @objc func dismissHUD() {
        hud.stopHUD()
    }
    

}

