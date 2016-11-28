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
    
    //MARK: - Authorization status
    fileprivate func requestAuthorization() {
        if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined {
            contactStore.requestAccess(for: .contacts) { _ in }
        }
    }
    
    //MARK: - Search contact by name
    func searchContact(with name: String, completion: @escaping ([CNContact]?, Error?) -> Void) {
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
    
    //MARK: - Search location for contact
    func searchLocation(for contact: CNContact, completion: @escaping (CLLocation?, Error?) -> Void) {
        if let streetAddress = contact.postalAddresses.first?.value {
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
}
