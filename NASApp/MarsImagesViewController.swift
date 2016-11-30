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
    
    //MARK: - Properties
    let photoManager = PhotoManager()
    var marsPhotos: [MarsPhoto]?

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select an image"

        photoManager.fetchLatestMarsImages() { marsPhotos, error in
            if let error = error {
                AlertManager.displayAlert(with: "Error", message: "\(error.localizedDescription)", in: self)
            } else if let photos = marsPhotos {
                self.marsPhotos = photos
                self.collectionView?.reloadData()
            }
        }
        
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let photos = marsPhotos else { return 0 }

        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MarsImageCell
    
        if let photos = marsPhotos {
            let photo = photos[indexPath.row]
            cell.configure(with: photo)
        }
        
        return cell
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMarsDetail" {
            let detailVC = segue.destination as! MarsDetailViewController
            if let indexPath = self.collectionView?.indexPathsForSelectedItems?.first {
                if let marsImage = self.marsPhotos?[indexPath.row] {
                    detailVC.photo = marsImage
                }
            }
        }
    }
}
