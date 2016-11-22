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
    
    let correctFakeAddress = "1465 5th Avenue, 10035 New York"
    let correctFakeContactName = "Daniel"
    
    let incorrectFakeAddress = "jdflg"
    let incorrectFakeContactName = "Alfred"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testMarsPhotoDownload() {
        photoManager.fetchLatestMarsImages { (imageStrings, _) in
            XCTAssertNotNil(imageStrings != nil, "There are no strings being downloaded")
        }
    }
    
    func testWorkingLocationSearch() {
    
    }
    
    func testWorkingContactSearch() {
    
    }
    
    func testFailingLocationSearch() {
        
    }
    
    func testFailingContactSearch() {
        
    }
}
