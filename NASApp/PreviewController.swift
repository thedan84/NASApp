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

    @IBOutlet weak var imageView: UIImageView!
    
    var previewImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = previewImage {
            print(image)
            self.imageView.image = image
        }
    }

    @IBAction func sendEmailButtonTapped(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.delegate = self
            
            composeVC.setMessageBody("Hello world", isHTML: false)
            
            self.present(composeVC, animated: true, completion: nil)
        } else {
            AlertManager.displayAlert(with: "Oops", message: "Seems like your device doesn't support sending e-mails, or you're not logged in.", in: self)
            return
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
