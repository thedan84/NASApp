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

class MarsDetailViewController: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    
    var inputAccessory: UIView!
    
    var photo: MarsPhoto?
    var image: UIImage?
    
    //MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    //MARK: - View configuration
    func configureViews() {
        if let photo = photo, let url = photo.imageURL {
            Nuke.loadImage(with: url, into: self.imageView)
//            Nuke.loadImage(with: url, into: self.imageView) { response, _ in
//                if let image = response?.image {
//                    self.imageView.image = image
//                    self.image = image
//                }
//            }
        }
        
        self.imageView.layer.cornerRadius = 20
        self.imageView.layer.borderWidth = 2
        self.imageView.layer.borderColor = UIColor.white.cgColor
        self.imageView.layer.masksToBounds = true
    }
    
    
    //MARK: - IBActions
    @IBAction func addTextButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Greeting", message: nil, preferredStyle: .alert)
        
        let previewAction = UIAlertAction(title: "Preview", style: .default) { previewAction in
            let textField = alert.textFields!.first! as UITextField
            if let text = textField.text {
                let previewVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviewVC") as! PreviewController
                if let image = self.image {
                    if let newImage = self.textToImage(text: text, image: image) {
                        previewVC.previewImage = newImage
                        self.navigationController?.pushViewController(previewVC, animated: true)
                    }
                }
                
            }
        }
        
        previewAction.isEnabled = false
        
        alert.addTextField() { textField in
            textField.placeholder = "Greetings from Mars"
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using: { (notification) in
                previewAction.isEnabled = textField.text != nil
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(previewAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Navigation
    
    fileprivate func textToImage(text: String?, image: UIImage?) -> UIImage? {
        guard let text = text, let image = image else { return nil }
        
        let textColor = UIColor.white
        guard let font = UIFont(name: "Zapfino", size: 20) else { return nil }
        
        UIGraphicsBeginImageContext(image.size)
        
        let fontAttributes = [
            convertFromNSAttributedStringKey(NSAttributedString.Key.font): font,
            convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): textColor
        ]
        
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            
        let rect = CGRect(x: 10, y: image.size.height - 100, width: image.size.width, height: image.size.height)
        
        text.draw(in: rect, withAttributes: convertToOptionalNSAttributedStringKeyDictionary(fontAttributes))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
