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
    
    //MARK: - Properties
    let photoManager = PhotoManager()
    let contactManager = ContactManager()
    let geocoder = Geocoder()
    
    let correctFakeAddress = "1465 5th Avenue, 10035 New York"
    let incorrectFakeAddress = "jdflg"
    
    let correctFakeContactName = "Daniel"
    let incorrectFakeContactName = "sdfs"
    
    var correctCNContact: CNMutableContact? = nil
    
    //MARK: - Set up and tear down
    override func setUp() {
        super.setUp()
        
        setupCorrectCNContact()
    }
    
    override func tearDown() {
        
        correctCNContact = nil

        super.tearDown()
    }
    
    //MARK: - Test download of mars photos
    func testMarsPhotoDownload() {
        photoManager.fetchLatestMarsImages { (marsPhotos, _) in
            XCTAssertNotNil(marsPhotos != nil, "There are no strings being downloaded")
        }
    }
    
    //MARK: - Test location search
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
    
    //MARK: - Test image download for contact
    func testImageDownloadForContact() {
        if let contact = correctCNContact {
            photoManager.fetchImage(for: contact) { imageString, _ in
                XCTAssertNotNil(imageString != nil, "The specified contact was not found")
            }
        }
    }
    
    //MARK: - Test image download for address
    func testImageDownloadForAddress() {
        photoManager.fetchImage(for: correctFakeAddress) { photo, _ in
            XCTAssertNotNil(photo != nil, "No image could be downloaded")
        }
    }
    
    func testFailingImageDownloadForAddress() {
        photoManager.fetchImage(for: incorrectFakeAddress) { photo, _ in
            XCTAssertNil(photo == nil, "The address provided was correct")
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
