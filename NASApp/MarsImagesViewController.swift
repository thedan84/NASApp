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
    
    var marsPhotos: [MarsPhoto]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Latest Mars Rover Images"

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
        if let photos = marsPhotos {
            return photos.count
        }
        
        return 0
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
        
    }
}
