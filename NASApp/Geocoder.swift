//
//  Geocoder.swift
//  NASApp
//
//  Created by Dennis Parussini on 20-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation
import CoreLocation

struct Geocoder {
    let geoCoder = CLGeocoder()
    
    func geocodeAddress(for addressString: String, completion: @escaping (CLLocation?) -> Void) {
        geoCoder.geocodeAddressString(addressString) { placemarks, error in
            
            if let placemark = placemarks?.first, let location = placemark.location {
                completion(location)
            }
        }
    }
}
