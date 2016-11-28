//
//  MarsDetailViewController.swift
//  NASApp
//
//  Created by Dennis Parussini on 27-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit
import Nuke

class MarsDetailViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendEmailButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var photo: MarsPhoto?
    
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
    }
    
    func configureViews() {
        if let photo = photo, let url = photo.imageURL {
           Nuke.loadImage(with: url, into: self.imageView)
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
    
    @IBAction func sendEmailButtonTapped(_ sender: UIButton) {
        print("tap")
    }
}
