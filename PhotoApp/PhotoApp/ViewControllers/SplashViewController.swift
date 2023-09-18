//
//  ViewController.swift
//  PhotoApp
//
//  Created by lelya.rumynin@gmail.com on 10.08.23.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    @IBOutlet weak var animationJSON: LottieAnimationView!
    
    var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       playAnimation()
        
        
    }
    
    private func playAnimation(){
        
        animationView = .init(name: "photo")
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.frame = animationJSON.bounds
        animationView.animationSpeed = 1
        animationView.play()
        animationJSON.addSubview(animationView)
        
        presentLoginController()
        
    }
    
    private func presentLoginController () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) { [weak self] in
            self?.animationJSON.pause()
            
            let desinationController = LoginViewController()
            desinationController.modalPresentationStyle = .fullScreen
            
            self?.present(desinationController, animated: true) 
        }
    }


}

