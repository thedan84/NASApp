//
//  Manifest.swift
//  NASApp
//
//  Created by Dennis Parussini on 20-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

struct Manifest {
    let maxSol: Int?
}

extension Manifest {
    init?(json: JSON) {
        guard let maxSol = json["max_sol"] as? Int else { return nil }
        
        self.maxSol = maxSol
    }
}
