//
//  MainVC.swift
//  ImagePickerHW
//
//  Created by Eugeny Matylitski on 28.07.22.
//

import Foundation
import UIKit


final class MainVC : UIViewController{
    @IBOutlet private weak var label : UILabel!
    @IBOutlet private weak var imageView : UIImageView!
    
    
    let imagePicker = UIImagePickerController()

    
    override func viewDidLoad() {
        imagePicker.delegate = self
    }
   
    @IBAction func screenDidTap(_ : UITapGestureRecognizer){
        let alert = UIAlertController(title: "Choose source", message: "Select what you want", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        let openCameraAction = UIAlertAction(title: "Open Camera", style: .default) { _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true)
        }
        alert.addAction(openCameraAction)
        
        let openGalleryAction = UIAlertAction(title: "Open Gallery", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        }
        alert.addAction(openGalleryAction)
        present(alert,animated: true)
    }
    
    @IBAction func longPress(){
        if imageView.image != nil {
            let alert = UIAlertController(title: "Remove", message: "you realy want to remove this picture?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive) { _ in
                self.imageView.image = nil
                self.imageView.isHidden = true
                self.label.isHidden = false
            }
            alert.addAction(deleteAction)
            present(alert, animated: true)
        } else{
            let alert = UIAlertController(title: "Error", message: "no image to remove", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ok", style: .default) { _ in
                alert.dismiss(animated: true)
            }
            alert.addAction(cancelAction)
            present(alert, animated: true)
            
        }
    }
    
    @IBAction func swipeUsed(){
        guard let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(CustomizationVC.self)") as? CustomizationVC else {return}
        guard let image = imageView.image else {return}
        nextVC.image = image
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
 
}

extension MainVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        self.imageView.image = image
        self.label.isHidden = true
        self.imageView.isHidden = false
        imagePicker.dismiss(animated: true)
    }
    
    
    
}
