//
//  Photo.swift
//  NASApp
//
//  Created by Dennis Parussini on 20-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

struct Photo {
    let imageURL: String?
}

extension Photo {
    init?(json: JSON) {
        guard let imageURL = json["img_src"] as? String else { return nil }
        
        self.imageURL = imageURL
    }
}
