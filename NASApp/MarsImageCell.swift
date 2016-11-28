//
//  MarsImageCell.swift
//  NASApp
//
//  Created by Dennis Parussini on 23-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit
import Nuke

class MarsImageCell: UICollectionViewCell {
    
    //MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Cell configuration
    func configure(with photo: MarsPhoto) {
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.5

        if let url = photo.imageURL {
            Nuke.loadImage(with: url, into: imageView)
        }
    }
}
