//
//  EarthPhoto.swift
//  NASApp
//
//  Created by Dennis Parussini on 27-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

struct EarthPhoto: Photo {
    
    //MARK: - Properties
    var imageURL: URL?
}

extension EarthPhoto {
    
    //MARK: - Initialization
    init?(json: JSON) {
        guard let url = json["url"] as? String else { return nil }
        
        self.imageURL = URL(string: url)
    }
}
