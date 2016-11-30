//
//  ContactManager.swift
//  NASApp
//
//  Created by Dennis Parussini on 22-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation
import Contacts
import CoreLocation

struct ContactManager {

    //MARK: - Properties
    let contactStore = CNContactStore()
    let geocoder = Geocoder()
        
    //MARK: - Search location for contact
    func searchLocation(for contact: CNContact, completion: @escaping (CLLocation?, Error?) -> Void) {
        guard let streetAddress = contact.postalAddresses.first?.value else {
            completion(nil, nil)
            return
        }
        
        let formattedAddress = CNPostalAddressFormatter.string(from: streetAddress, style: .mailingAddress)
        self.geocoder.geocodeAddress(for: formattedAddress) { (location, error) in
            
            if let error = error {
                completion(nil, error)
            } else if let location = location {
                completion(location, nil)
            }
        }
    }
}
