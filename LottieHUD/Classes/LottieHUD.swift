//
//  LottieHUD.swift
//  LottieHUD
//
//  Created by Ahmed Raad on 4/8/19.
//  Copyright © 2019 Ahmed Raad. All rights reserved.
//

import Foundation
import Lottie

public class LottieHUDAppearance {
    /// Source file of animation (Note: will crash if never set)
    public var source: LottieHUDFileSource?
    /// Default style (black).
    public var backgroundStyle = LottieHUDBackgroundStyle.black
    /// Default overlay size (full).
    public var overlaySize = LottieHUDOverlaySize.full
    /// loop mode (Default: .loop)
    public var loop = LottieLoopMode.loop
    /// animation size (Default width: 0, height: 200).
    public var animationSize = CGSize(width: 0, height: 200)
    /// presentation animation duration (Default 0.3).
    public var presentDuration = TimeInterval(0.3)
    /// animation duration (Default 1.0).
    public var animationSpeed = TimeInterval(1.0)
    /// corner reduis (works only with custom overlay size) (Default 5 px).
    public var corner: CGFloat = 5.0
    /// if (true) the lottie animation will playing before presentation completion called (Default true).
    public var playImmediately = true
    /// Will dismiss hud when finish works only when mode (playOnce) (Default false).
    public var dismissWhenAnimationFinished = false
    
    public init(source: LottieHUDFileSource) {
        self.source = source
    }
    
    public init() {}
}

public class LottieHUD {
    
    public typealias LottieHUDCompletion = (() -> Void)
    
    public static let shared = LottieHUD()

    fileprivate(set) public var appearance = LottieHUDAppearance()
    
    fileprivate var completion: LottieHUDCompletion?
    
    var currentAppearance: LottieHUDAppearance?
    
    var keyWindow: UIWindow? {
        var keyWindow: UIWindow?
        UIApplication.shared.windows.forEach { (window) in
            if  window.screen == UIScreen.main,
                window.isHidden == false,
                window.alpha > 0,
                window.windowLevel >= UIWindow.Level.normal {
                keyWindow = window
                return
            }
        }
        return keyWindow
    }
        
   lazy var hudView: UIControl = {
        let view = UIControl()
        return view
    }()
    
    var lottieAnimationView: AnimationView = {
        var view = AnimationView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        return view
    }()
    
}

extension LottieHUD {
    
    public static func show(with appearance: LottieHUDAppearance? = nil, _ completion: LottieHUDCompletion? = nil) {
        
        if let currentAppearance = appearance {
            shared.currentAppearance = currentAppearance
            shared.show(appearance: currentAppearance, completion: completion)
        } else {
            shared.show(appearance: shared.appearance, completion: completion)
        }
    }
    
    public static func hide(_ completion: LottieHUDCompletion? = nil) {
        shared.dismiss(completion: completion)
    }
}
