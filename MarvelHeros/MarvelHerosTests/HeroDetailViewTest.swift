//
//  HeroDetailViewTest.swift
//  MarvelHerosTests
//
//  Created by Geovanni Oliveira de Jesus on 15/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import XCTest
@testable import MarvelHeros

class HeroDetailViewTest: XCTestCase {

    override func setUpWithError() throws {
        
    }

    func testSetDetailView() throws {
        let nib = UINib(nibName: "HeroDetailView", bundle:nil)
        let myVC = nib.instantiate(withOwner: self, options: nil)[0] as? HeroDetailViewController
           
        myVC?.hero = HeroModel(name: "Teste",
                               description: "teste description",
                               imagePath: "imgURL",
                               imageExtension: ".jpg",
                               imageData: Data())
        myVC?.viewDidLoad()
        XCTAssertEqual(myVC?.hero?.name, "Teste")
    }

}
