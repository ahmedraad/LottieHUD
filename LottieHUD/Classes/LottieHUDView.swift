//
//  LottieHUDView.swift
//  LottieHUD
//
//  Created by Ahmed Raad on 4/8/19.
//  Copyright © 2019 Ahmed Raad. All rights reserved.
//

import Foundation
import SnapKit
import Lottie

extension LottieHUD {
    
    func configure(appearance: LottieHUDAppearance) {
        switch appearance.source {
        case .name(let name)?:
            lottieAnimationView = AnimationView(name: name)
        case .localPath(let path)?:
            lottieAnimationView = AnimationView(filePath: path)
        default:
            break
        }
        lottieAnimationView.loopMode = appearance.loop
        lottieAnimationView.animationSpeed = CGFloat(appearance.animationSpeed)
        
        hudView = appearance.backgroundStyle.backgroundView
        
        switch appearance.overlaySize {
        case .custom(_):
            hudView.layer.cornerRadius = appearance.corner
            hudView.transform = .init(scaleX: 0.95, y: 0.95)
        default:
            break
        }
    }
    
    func configureUI(appearance: LottieHUDAppearance) {
        guard appearance.source != nil else {
            fatalError("Animation soure file missing")
        }
        
        hudView.addSubview(lottieAnimationView)
        keyWindow?.addSubview(hudView)
        
        switch appearance.overlaySize {
        case .full:
            hudView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            lottieAnimationView.snp.makeConstraints { make in
                if appearance.animationSize.width > 0 {
                    make.width.equalTo(appearance.animationSize.width)
                } else {
                    make.leading.equalToSuperview().offset(10)
                    make.trailing.equalToSuperview().offset(-10)
                }
                make.centerY.equalToSuperview()
                make.height.equalTo(appearance.animationSize.height)
            }
        case .custom(let size):
            hudView.snp.makeConstraints { make in
                make.height.equalTo(size.height)
                make.width.equalTo(size.width)
                make.center.equalToSuperview()
            }
            lottieAnimationView.snp.makeConstraints { make in
                if appearance.animationSize.width > 0 && appearance.animationSize.width <= size.width {
                    make.width.equalTo(appearance.animationSize.width)
                } else {
                    make.leading.equalToSuperview().offset(10)
                    make.trailing.equalToSuperview().offset(-10)
                }
                make.centerY.equalToSuperview()
                if appearance.animationSize.height <= size.height {
                    make.height.equalTo(appearance.animationSize.height)
                } else {
                    make.height.equalTo(size.height)
                }
            }
        }

    }
    
    
    func show(appearance: LottieHUDAppearance, completion: LottieHUDCompletion?) {
        configure(appearance: appearance)
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.configureUI(appearance: appearance)
            strongSelf.fadeIn(appearance: appearance, completion: completion)
        }
    }
    
    func dismiss(completion: LottieHUDCompletion?) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.fadeOut(completion: completion)
        }
    }
    
    
    private func fadeIn(appearance: LottieHUDAppearance, completion: LottieHUDCompletion?) {
        UIView.animate(withDuration: appearance.presentDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: { [weak self] in
            
            guard let strongSelf = self else { return }
            
            switch appearance.overlaySize {
            case .custom(_):
                strongSelf.hudView.transform = .identity
            default:
                break
            }
            
            strongSelf.hudView.alpha = 1.0
            if appearance.playImmediately {
                strongSelf.lottieAnimationView.play(completion: { _ in
                    if appearance.dismissWhenAnimationFinished {
                        strongSelf.dismiss(completion: completion)
                    }
                })
            }
            
        }) { _ in
            if !appearance.playImmediately {
                self.lottieAnimationView.play(completion: { _ in
                    if appearance.dismissWhenAnimationFinished {
                        self.dismiss(completion: completion)
                    }
                })
            }
        }
    }
    
    private func fadeOut(completion: LottieHUDCompletion?) {
        
        var appearance: LottieHUDAppearance!
        
        if let current = currentAppearance {
            appearance = current
        } else {
            appearance = self.appearance
        }
        
        
        UIView.animate(withDuration: appearance.presentDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: { [weak self] in
            
            guard let strongSelf = self else { return }
            
            switch appearance.overlaySize {
            case .custom(_):
                strongSelf.hudView.transform = .init(scaleX: 0.95, y: 0.95)
            default:
                break
            }
            
            strongSelf.hudView.alpha = 0
            
        }) { _ in
            self.lottieAnimationView.stop()
            self.reset()
            completion?()
        }
    }
    
    
    private func reset() {
        currentAppearance = nil
        hudView.layer.cornerRadius = 0
        hudView.transform = .identity
        lottieAnimationView.snp.removeConstraints()
        hudView.snp.removeConstraints()
        lottieAnimationView.removeFromSuperview()
        hudView.removeFromSuperview()
        
    }
}
