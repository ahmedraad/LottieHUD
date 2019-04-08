//
//  LottieHUD.swift
//  LottieHUD
//
//  Created by Ahmed Raad on 4/8/19.
//  Copyright © 2019 Ahmed Raad. All rights reserved.
//

import Foundation
import Lottie

open class LottieHUD {
    
    open class LottieHUDAppearance {
        /// Default style (black).
        public var backgroundStyle = LottieHUDBackgroundStyle.black
        /// Default frame size (full).
        public var size = LottieHUDFrameSize.full
        /// presentation animation duration (Default 0.3).
        public var presentDuration = TimeInterval(0.3)
        
        fileprivate init() {}
    }
    
    static let shared = LottieHUD()
    
    let appearance = LottieHUDAppearance()
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    let hudController = LottieHUDController()
    
    internal var hudView = UIView()
    private var lottieAnimationView: AnimationView!
    
    private init() {
        configureUI()
    }
}
