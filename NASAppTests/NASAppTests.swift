//
//  NASAppTests.swift
//  NASAppTests
//
//  Created by Dennis Parussini on 16-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import XCTest
@testable import NASApp

class NASAppTests: XCTestCase {
    
    let photoManager = PhotoManager()
    var fakeAddress: String?
    
    override func setUp() {
        super.setUp()
        
        //Uncomment this line to test location search with a correct address
//        fakeAddress = "1465 5th Avenue, 10035 New York"
        
        //Uncomment this line to test location search with an incorrect address
        fakeAddress = "jdflg"
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testMarsPhotoDownload() {
        photoManager.fetchLatestMarsImages { (imageStrings, error) in
            if error != nil {
                print(error!)
            } else {
                XCTAssertNotNil(imageStrings != nil, "There are no strings being downloaded")
            }
        }
    }
    
    func testLocationSearch() {
        if let address = fakeAddress {
            photoManager.fetchEarthImage(for: address, completion: { (photoString, error) in
                if error != nil {
                    XCTAssert(photoString == nil, "The address provided was correct")
                } else {
                    XCTAssert(error == nil, "The address provided was incorrect")
                }
            })
        }
    }
}
