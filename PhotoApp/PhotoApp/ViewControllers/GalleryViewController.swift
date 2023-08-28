//
//  GalleryViewController.swift
//  PhotoApp
//
//  Created by lelya.rumynin@gmail.com on 11.08.23.
//

import UIKit
import Foundation

class GalleryViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let numberOfRows:CGFloat = 3
    let cellSpacing:CGFloat = 5
    
    var photos: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        loadImage()
        
    }
    
    private func setupCollectionView(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
        
    }
    
    private func registerCell(){
        
        let photoNib = UINib(nibName: "PhotoCollectionViewCell", bundle: Bundle.main)
        collectionView.register(photoNib, forCellWithReuseIdentifier: "photoCell")
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func plusButton(_ sender: Any) {
        
        showAlerts()
        
    }
    
    private func showAlerts(){
        
        let alert = UIAlertController(title: "Add photo", message: "Choose app for adding photo", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.allowsEditing = false
            pickerController.mediaTypes = ["public.image"]
            pickerController.sourceType = .camera
            self?.present(pickerController, animated: true)
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { [weak self] _ in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.allowsEditing = false
            pickerController.mediaTypes = ["public.image"]
            pickerController.sourceType = .photoLibrary
            self?.present(pickerController, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
        
    }
    
    func saveImage(_ images: [UIImage]) {
        
        for photo in images {
            
            //
            // нужно сюда for
            //
            
            guard let saveDirectory =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first, let imageData = photo.pngData() else {return}
            
            let fileName = UUID().uuidString
            
            let fileURL = URL(fileURLWithPath: fileName,relativeTo: saveDirectory).appendingPathExtension("png")
            
            try? imageData.write(to: fileURL)
            
            URLManager.addImageName(fileName)
            
            loadImage(from: fileURL.absoluteURL)
            
            print("file saved \(fileURL.absoluteURL)")
            
        }
        
        collectionView.reloadData()
        
    }
    
    func loadImage(from fileURL: URL) {
        guard let savedData = try? Data(contentsOf: fileURL),
              let image = UIImage(data: savedData) else { return }
        
        photos.append(image)
        collectionView.reloadData()
    }
    
    func loadImage() {
        
        // сюда нужно вставить for
        
        
        
        guard let saveDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first, let fileName = URLManager.getImagesNames().first else {return}
        
        let fileURL = URL(fileURLWithPath: fileName, relativeTo: saveDirectory).appendingPathExtension("png")
        
        guard let saveData = try? Data(contentsOf: fileURL),let image = UIImage(data: saveData) else {return}
        
        photos.append(image)
        collectionView.reloadData()
        
    }
    
}

extension GalleryViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        guard let image = info[.originalImage] as? UIImage else {
            
            return
        }
        photos.append(image)
        saveImage(photos)
        
        picker.dismiss(animated: true)
    }
    
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        photos.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell else{return UICollectionViewCell()}
        
        cell.photoImage.image = photos[index]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        let destination = PhotoViewController()
        destination.photo = photos[index]
        destination.modalPresentationStyle = .fullScreen
        present(destination, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - (numberOfRows - 1) * cellSpacing) / numberOfRows
        
        return CGSize(width: collectionView.bounds.size.width / 3 - cellSpacing * 2, height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
}
