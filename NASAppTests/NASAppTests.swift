//
//  NASAppTests.swift
//  NASAppTests
//
//  Created by Dennis Parussini on 16-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import XCTest
@testable import NASApp
import Contacts

class NASAppTests: XCTestCase {
    
    let photoManager = PhotoManager()
    let contactManager = ContactManager()
    let geocoder = Geocoder()
    
    let correctFakeAddress = "1465 5th Avenue, 10035 New York"
    let incorrectFakeAddress = "jdflg"
    
    let correctFakeContactName = "Daniel"
    let incorrectFakeContactName = "sdfs"
    
    var correctCNContact: CNMutableContact? = nil
    
    override func setUp() {
        super.setUp()
        
        setupCorrectCNContact()
    }
    
    override func tearDown() {
        
        correctCNContact = nil

        super.tearDown()
    }
    
    func testMarsPhotoDownload() {
        photoManager.fetchLatestMarsImages { (marsPhotos, _) in
            XCTAssertNotNil(marsPhotos != nil, "There are no strings being downloaded")
        }
    }
    
    func testWorkingLocationSearch() {
        geocoder.geocodeAddress(for: correctFakeAddress) { location, _ in
            XCTAssertNotNil(location != nil, "The specified address is incorrect")
        }
    }
    
    func testFailingLocationSearch() {
        geocoder.geocodeAddress(for: incorrectFakeAddress) { location, _ in
            XCTAssertNil(location == nil, "The specified address is correct")
        }
    }
    
    func testWorkingContactSearch() {
        contactManager.searchContact(with: correctFakeContactName) { contacts, _ in
            XCTAssertNotNil(contacts != nil, "The specified contact's name is incorrect")
        }
    }
    
    func testFailingContactSearch() {
        contactManager.searchContact(with: incorrectFakeContactName) { contacts, _ in
            XCTAssertNil(contacts == nil, "The specified contact's name is correct")
        }
    }
    
    func testImageDownloadForContact() {
        if let contact = correctCNContact {
            photoManager.fetchImage(for: contact) { imageString, _ in
                XCTAssertNotNil(imageString != nil, "The specified contact was not found")
            }
        }
    }
    
    //MARK: - Helper
    func setupCorrectCNContact() {
        correctCNContact?.givenName = "Daniel"
        correctCNContact?.familyName = "Higgins"
        
        let postalAddress = CNMutablePostalAddress()
        postalAddress.city = "New York"
        postalAddress.country = "USA"
        postalAddress.postalCode = "10035"
        postalAddress.state = "New York"
        postalAddress.street = "1465 5th Avenue"
        
        let labeledValue: CNLabeledValue<CNPostalAddress> = CNLabeledValue(label: "Home", value: postalAddress)
        
        correctCNContact?.postalAddresses = [labeledValue]
    }
}
