//
//  MarsDetailViewController.swift
//  NASApp
//
//  Created by Dennis Parussini on 27-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit
import Nuke
import MessageUI
import CoreGraphics

class MarsDetailViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var photo: MarsPhoto?
    var image: UIImage?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self

        textView.becomeFirstResponder()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapRecognizer)
        tapRecognizer.delegate = self
        
        let rightBarButton = UIBarButtonItem(title: "Preview", style: .plain, target: self, action: #selector(previewImage))
        let attributes = [
            NSForegroundColorAttributeName: UIColor.white
        ]
        rightBarButton.setTitleTextAttributes(attributes, for: .normal)
        self.navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    
    func configureViews() {
        if let photo = photo, let url = photo.imageURL {
            Nuke.loadImage(with: url, into: self.imageView) { response, _ in
                if let image = response.value {
                    self.imageView.image = image
                    self.image = image
                }
            }
        }
        
        self.imageView.layer.cornerRadius = 20
        self.imageView.layer.borderWidth = 2
        self.imageView.layer.borderColor = UIColor.white.cgColor
        self.imageView.layer.masksToBounds = true
        
        self.textView.layer.cornerRadius = 20
        self.textView.layer.borderWidth = 2
        self.textView.layer.borderColor = UIColor.white.cgColor
        self.textView.layer.masksToBounds = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
    
    func dismissKeyboard() {
        textView.resignFirstResponder()
    }
    
    //MARK: - Navigation
    func previewImage() {
        let previewVC = storyboard?.instantiateViewController(withIdentifier: "PreviewVC") as! PreviewController
        if let image = self.image {
            if let newImage = textToImage(text: self.textView.text, image: image) {
                previewVC.previewImage = newImage
                self.navigationController?.pushViewController(previewVC, animated: true)
            }
        }
    }
    
    //MARK: - Helper
    fileprivate func textToImage(text: String?, image: UIImage?) -> UIImage? {
        guard let text = text, let image = image else { return nil }
        
        let textColor = UIColor.white
        guard let font = UIFont(name: "Zapfino", size: 25) else { return nil }
        
        UIGraphicsBeginImageContext(image.size)
        
        let fontAttributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: textColor
        ]
        
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            
        let rect = CGRect(x: 50, y: image.size.height - 100, width: image.size.width, height: image.size.height)
        
        text.draw(in: rect, withAttributes: fontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
