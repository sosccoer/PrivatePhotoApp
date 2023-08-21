//
//  LoginViewController.swift
//  PhotoApp
//
//  Created by lelya.rumynin@gmail.com on 10.08.23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordLabel: UILabel!
    
    let sucesfullPassword = "1111"
    var nowPassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkPassword(){
        
        passwordLabel.text = nowPassword
        
        if sucesfullPassword == nowPassword {
            presentGalleryController()
            nowPassword = ""
            checkPassword()
        }
    }
    
    func presentGalleryController(){
        let galleryController = GalleryViewController()
        galleryController.modalPresentationStyle = .fullScreen
        present(galleryController, animated: true)
        
    }


    @IBAction func numberButtons(_ sender: AnyObject) {
        
        guard let number = sender.tag else {return}
        
        nowPassword += String(number)
        checkPassword()
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        if nowPassword > "" {
            nowPassword.removeLast()
        }
        
        checkPassword()
        
    }
    
    
    @IBAction func faceIDButton(_ sender: Any) {
        presentGalleryController()
        nowPassword = ""
    }
    
  
    
}
