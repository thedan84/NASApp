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
    
    let contactStore = CNContactStore()
    let geocoder = Geocoder()
    
    func requestAuthorization() {
        if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined {
            contactStore.requestAccess(for: .contacts) { _ in }
        }
    }
    
    fileprivate func searchContact(with name: String, completion: @escaping ([CNContact]?, Error?) -> Void) {
        requestAuthorization()
        
        let predicate: NSPredicate = CNContact.predicateForContacts(matchingName: name)
        
        let givenNameKey = CNContactGivenNameKey as CNKeyDescriptor
        let familyNameKey = CNContactFamilyNameKey as CNKeyDescriptor
        let addressDescriptor = CNContactPostalAddressesKey as CNKeyDescriptor
        
        let keysToFetch = [givenNameKey, familyNameKey, addressDescriptor]
        
        do {
            let contacts = try contactStore.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
            
            OperationQueue.main.addOperation {
                completion(contacts, nil)
            }
        } catch {
            completion(nil, error)
        }
    }
    
    func searchLocationForContact(with name: String, completion: @escaping (CLLocation?, Error?) -> Void) {
        self.searchContact(with: name) { contacts, error in
            if error != nil {
                completion(nil, error)
            } else if let contacts = contacts {
                for contact in contacts {
                    for address in contact.postalAddresses {
                        let address = address.value
                        let formattedAddress = CNPostalAddressFormatter.string(from: address, style: .mailingAddress)
                        self.geocoder.geocodeAddress(for: formattedAddress) { location, error in
                            if error != nil {
                                completion(nil, error)
                            } else if let location = location {
                                completion(location, nil)
                            }
                        }
                    }
                }
            }
        }
    }
}
