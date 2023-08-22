//
//  PhotoViewController.swift
//  PhotoApp
//
//  Created by lelya.rumynin@gmail.com on 21.08.23.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet  var imageView: UIImageView!
    
    var photo = UIImage()
    
    var imageOrientation: UIImage.Orientation = .up
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPhoto ()
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    func setupPhoto () {
        imageView.image = photo
    }
    
    @IBAction func rotatePhoto(_ sender: Any) {
        
        imageView.image = rotateImage(image: photo )
    }
    
    func rotateImage(image:UIImage) -> UIImage
        {
            var rotatedImage = UIImage()
            switch imageOrientation
            {
                case .right:
                    rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .down)
                imageOrientation = .down
                case .down:
                    rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .left)
                imageOrientation = .left
                case .left:
                    rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .up)
                imageOrientation = .up
                default:
                    rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .right)
                imageOrientation = .right
            }
            
            return rotatedImage
            
        }

}
