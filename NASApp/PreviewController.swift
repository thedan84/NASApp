//
//  PreviewController.swift
//  NASApp
//
//  Created by Dennis Parussini on 28-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit
import MessageUI

class PreviewController: UIViewController, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
    
    //MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    
    var previewImage: UIImage?
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = previewImage {
            self.imageView.image = image
        }
    }

    //MARK: - IBAction
    @IBAction func sendEmailButtonTapped(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            guard let image = previewImage else { return }
            
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                composeVC.addAttachmentData(imageData, mimeType: "image/jpeg", fileName: "\(imageData.description)")
            }
            
            self.present(composeVC, animated: true, completion: nil)
        } else {
            AlertManager.displayAlert(with: "Oops", message: "Seems like your device doesn't support sending e-mails, or you're not logged in.", in: self)
            return
        }
    }
    
    //MARK: - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
