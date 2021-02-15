//
//  HeroHomeViewController.swift
//  MarvelHerosTests
//
//  Created by Geovanni Oliveira de Jesus on 15/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import XCTest
@testable import MarvelHeros

class HeroHomeViewController: XCTestCase {
    var sut: HeroHomeViewController!
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTestNotNilViewController() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = (storyboard.instantiateViewController(withIdentifier: "HeroHomeViewController"))
        XCTAssertNotNil(vc)
        
    }
}
