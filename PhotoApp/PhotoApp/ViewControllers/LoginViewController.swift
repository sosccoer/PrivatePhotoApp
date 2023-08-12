//
//  LoginViewController.swift
//  PhotoApp
//
//  Created by lelya.rumynin@gmail.com on 10.08.23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordLabel: UILabel!
    
    let sucesfullPassword = "195713"
    var nowPassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkPassword(){
        
        passwordLabel.text = nowPassword
        
        if sucesfullPassword == nowPassword {
            let galleryController = GalleryViewController()
            galleryController.modalPresentationStyle = .fullScreen
            present(galleryController, animated: true)
            nowPassword = ""
            checkPassword()
        }
    }


    @IBAction func numberButtons(_ sender: AnyObject) {
        
        guard let number = sender.tag else {return}
        
        nowPassword += String(number)
        checkPassword()
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        nowPassword.removeLast()
        checkPassword()
        
    }
    
    
    
  
    
}
