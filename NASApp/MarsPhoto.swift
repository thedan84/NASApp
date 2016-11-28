//
//  Photo.swift
//  NASApp
//
//  Created by Dennis Parussini on 27-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

struct MarsPhoto: Photo {
    
    //MARK: - Properties
    let imageURL: URL?
}

extension MarsPhoto {
    
    //MARK: - Initialization
    init?(json: JSON) {
        guard let imageString = json["img_src"] as? String else { return nil }

        self.imageURL = URL(string: imageString)
    }
}
