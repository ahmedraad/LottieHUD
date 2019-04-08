//
//  LottieHUDType.swift
//  LottieHUD
//
//  Created by Ahmed Raad on 4/8/19.
//  Copyright © 2019 Ahmed Raad. All rights reserved.
//

import Foundation
import UIKit

public enum LottieHUDFrameSize {
    
    case full, squared, custom(CGSize)
    
    var size: CGSize {
        switch self {
        case .full: return UIScreen.main.bounds.size
        case .squared: return CGSize(width: 200, height: 200)
        case .custom(let size): return size
        }
    }
}

public enum LottieHUDBackgroundStyle {
    
    case black, white, clear, custom(UIColor)
    
    var backgroundView: UIView {
        
        let backgroundView = UIView()
        
        switch self {
        case .black:
            backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        case .white:
            backgroundView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        case .clear:
            backgroundView.backgroundColor = .clear
        case .custom(let color):
            backgroundView.backgroundColor = color
        }
        
        return backgroundView
    }
}


public enum LottieHUDFileSource {
    
    case name(String), contentsOf(URL), json([AnyHashable: Any])
    
}
