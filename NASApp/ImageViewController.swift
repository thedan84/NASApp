//
//  ImageViewController.swift
//  NASApp
//
//  Created by Dennis Parussini on 29-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit
import Nuke

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var photo: EarthPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let photo = photo, let url = photo.imageURL else { return }
        
        Nuke.loadImage(with: url, into: imageView)
    }
}
