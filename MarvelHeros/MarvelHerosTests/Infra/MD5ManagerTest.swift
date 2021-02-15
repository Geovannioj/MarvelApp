//
//  MD5ManagerTest.swift
//  MarvelHerosTests
//
//  Created by Geovanni Oliveira de Jesus on 15/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import XCTest
@testable import MarvelHeros

class MD5ManagerTest: XCTestCase {
    
    var sut: MD5Manager!
    
    override func setUp() {
        sut = MD5Manager()
    }
    
    override class func tearDown() {
        
    }
    
    func testMD5NotNilt() {
        XCTAssertNotNil(sut)
    }
    
}
