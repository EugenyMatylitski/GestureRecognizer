//
//  CustomizationVC.swift
//  ImagePickerHW
//
//  Created by Eugeny Matylitski on 28.07.22.
//

import Foundation
import UIKit

final class CustomizationVC : UIViewController{
    
    @IBOutlet private weak var imageView : UIImageView!
    @IBOutlet private weak var imageViewWidthConstraint : NSLayoutConstraint!
    @IBOutlet private weak var imageViewHeightConstraint : NSLayoutConstraint!
    
    @IBOutlet private weak var imageViewCenterXConstraint : NSLayoutConstraint!
    @IBOutlet private weak var imageViewCenterYConstraint : NSLayoutConstraint!
    
    var imageViewStartWidth : CGFloat?
    var imageViewStartHeight : CGFloat?
    
    var imageViewStartXcenter : CGFloat?
    var imageViewStartYcenter : CGFloat?
    
    var image : UIImage?
    var frame : CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup(){
        imageView.image = image
        frame = imageView.frame
        
        imageViewStartXcenter = imageViewCenterXConstraint.constant
        imageViewStartYcenter = imageViewCenterYConstraint.constant
        imageViewStartWidth = imageViewWidthConstraint.constant
        imageViewStartHeight = imageViewHeightConstraint.constant
    }
    
    @IBAction func pinchGesture(recognizer : UIPinchGestureRecognizer){
        imageViewWidthConstraint.constant *= recognizer.scale
        imageViewHeightConstraint.constant *= recognizer.scale
        recognizer.scale = 1
    }
    
    @IBAction func rotationGesture(recognizer : UIRotationGestureRecognizer){
        guard let rotatedView = recognizer.view else {return}
        rotatedView.transform = rotatedView.transform.rotated(by: recognizer.rotation)
        print(recognizer.rotation)
        recognizer.rotation = 0
    }
    
    @IBAction func panGesture(recognizer : UIPanGestureRecognizer){
        let newPoint = recognizer.translation(in: self.view)
        self.imageViewCenterXConstraint.constant += newPoint.x
        self.imageViewCenterYConstraint.constant += newPoint.y
        recognizer.setTranslation(.zero, in: self.view)
    }
    
    @IBAction func longTapGesture(recognizer : UILongPressGestureRecognizer){
        guard let view = recognizer.view else {return}
        guard let startHeight = imageViewStartHeight else {return}
        if recognizer.state == .began{
            if imageViewHeightConstraint.constant != startHeight{
                view.transform = CGAffineTransform(rotationAngle: 0)
                imageViewHeightConstraint.constant = startHeight
            }else {
                view.transform = CGAffineTransform(rotationAngle: .pi / 2)
                imageViewHeightConstraint.constant = UIScreen.main.bounds.width - 40
            }
        }
        
    }
    
    @IBAction func tapGesture (recognizer: UITapGestureRecognizer){
        guard let tappedView = recognizer.view else {return}
        
        UIView.animate(withDuration: 0.2, delay: 0, options: []) {
            if let width = self.imageViewStartWidth ,
               let height = self.imageViewStartHeight,
               let centerX = self.imageViewStartXcenter,
               let centerY = self.imageViewStartYcenter {
                self.imageViewCenterXConstraint.constant = centerX
                self.imageViewCenterYConstraint.constant = centerY
                self.imageViewHeightConstraint.constant = height
                self.imageViewWidthConstraint.constant = width
                tappedView.frame = self.frame
                tappedView.transform = CGAffineTransform(rotationAngle: 0)
            }
        }
    }
    
}
