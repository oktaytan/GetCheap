//
//  LoadingView.swift
//  Kartoon
//
//  Created by Oktay Tanrıkulu on 28.03.2023.
//

import UIKit
import Lottie


final class LoadingView: UIViewController {
    
    let animationView: LottieAnimationView = {
        let view = LottieAnimationView(name: "loading.json")
        view.loopMode = .loop
        view.play()
        return view
    }()
    
    lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .blueSoft
        label.text = "Loading..."
        label.textAlignment = .center
        return label
    }()
    
    lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.alpha = 0.8
        
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubviews()
    }
    
    private func loadSubviews() {
        view.backgroundColor = .clear
        
        blurEffectView.frame = self.view.bounds
        view.insertSubview(blurEffectView, at: 0)
        
        animationView.frame.size = CGSize(width: 75.0, height: 75.0)
        animationView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(animationView)
        
        view.addSubview(loadingLabel)
        loadingLabel.anchor(top: animationView.bottomAnchor, left: animationView.leftAnchor, bottom: nil, right: animationView.rightAnchor, paddingTop: -15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: animationView.bounds.width, height: 22)
    }
}
