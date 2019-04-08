//
//  LottieHUDView.swift
//  LottieHUD
//
//  Created by Ahmed Raad on 4/8/19.
//  Copyright © 2019 Ahmed Raad. All rights reserved.
//

import Foundation

extension LottieHUD {
    
    func configure() {
        hudView = appearance.backgroundStyle.backgroundView
        
        window.windowLevel = .normal
        hudController.view.translatesAutoresizingMaskIntoConstraints = false
        hudController.view.backgroundColor = .clear
        
        hudController.view.addSubview(hudView)
        
        
        
    }
    
    func configureUI() {
        
    }
}
