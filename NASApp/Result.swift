//
//  Result.swift
//  NASApp
//
//  Created by Dennis Parussini on 20-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

enum Result {
    case success(JSON?)
    case failure(Error?)
}
