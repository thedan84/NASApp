//
//  Photo.swift
//  NASApp
//
//  Created by Dennis Parussini on 27-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

protocol Photo {
    
    //MARK: - Properties
    var imageURL: URL? { get }
    
    //MARK: - Initialization
    init?(json: JSON)
}
