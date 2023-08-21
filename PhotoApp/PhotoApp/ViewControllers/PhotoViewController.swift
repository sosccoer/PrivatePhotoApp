//
//  PhotoViewController.swift
//  PhotoApp
//
//  Created by lelya.rumynin@gmail.com on 21.08.23.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet  var imageView: UIImageView!
    
    var photo = PhotoViewController.nowPhoto
    
    static var nowPhoto: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPhoto ()
        
    }
    
    func setupPhoto () {
        imageView.image = photo
    }
    
    @IBAction func rotatePhoto(_ sender: Any) {
        
        imageView.image = rotateImage(image: photo!)
    }
    
    func rotateImage(image:UIImage) -> UIImage
    {
        var rotatedImage = UIImage()
        switch image.imageOrientation
        {
            case .right:
                rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .up)
            case .down:
                rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .right)
            case .left:
                rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .down)
            default:
                rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .left)
        }
        
        
        
        return rotatedImage
    }
        
}
