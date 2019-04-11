//
//  LottieHUDType.swift
//  LottieHUD
//
//  Created by Ahmed Raad on 4/8/19.
//  Copyright © 2019 Ahmed Raad. All rights reserved.
//

import Foundation
import UIKit

public enum LottieHUDOverlaySize {
    
    case full, custom(CGSize)
    
    var size: CGSize {
        switch self {
        case .full: return UIScreen.main.bounds.size
        case .custom(let size): return size
        }
    }
}

public enum LottieHUDBackgroundStyle {
    
    case black, white, clear, custom(UIColor)
    
    var backgroundView: UIControl {
        
        let backgroundView = UIControl()
        backgroundView.alpha = 0
        switch self {
        case .black:
            backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        case .white:
            backgroundView.backgroundColor = UIColor(white: 1, alpha: 0.7)
        case .clear:
            backgroundView.backgroundColor = .clear
        case .custom(let color):
            backgroundView.backgroundColor = color
        }
        
        return backgroundView
    }
}


public enum LottieHUDFileSource {
    
    case name(String), remoteURL(URL), localPath(String)
    
}
