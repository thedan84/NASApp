//
//  Photo.swift
//  NASApp
//
//  Created by Dennis Parussini on 27-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

protocol Photo {
    var imageURL: URL? { get }
    
    init?(json: JSON)
}
