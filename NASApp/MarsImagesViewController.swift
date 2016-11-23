//
//  MarsImagesViewController.swift
//  NASApp
//
//  Created by Dennis Parussini on 23-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

private let reuseIdentifier = "imageCell"

class MarsImagesViewController: UICollectionViewController {
    
    let photoManager = PhotoManager()
    
    var imageStringsArray: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Latest Mars Rover Images"

        photoManager.fetchLatestMarsImages() { imageStrings, error in
            if let error = error {
                AlertManager.displayAlert(with: "Error", message: "\(error.localizedDescription)", in: self)
            } else if let strings = imageStrings {
                self.imageStringsArray = strings
                self.collectionView?.reloadData()
            }
        }
        
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let strings = imageStringsArray {
            return strings.count
        }
        
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MarsImageCell
    
        if let strings = imageStringsArray {
            let imageString = strings[indexPath.row]
            cell.configure(with: imageString)
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
