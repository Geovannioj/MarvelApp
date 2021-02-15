//
//  NetworkManagerTest.swift
//  MarvelHerosTests
//
//  Created by Geovanni Oliveira de Jesus on 15/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import XCTest
@testable import MarvelHeros

class NetworkManagerTest: XCTestCase {

    var sut: NetworkManager!
    
    override func setUpWithError() throws {
        sut = NetworkManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSutNotNil() throws {
        XCTAssertNotNil(sut)
    }
    
    func testRequestData() {
        sut.requestData(offset: 0) { (result, content) in
            if result == .success {
                self.waitForExpectations(timeout: 5, handler: nil)
                XCTAssertTrue(content!.count > 0)
            }
        }
    }
    
    func testDownloadImage() {
        let urlStr = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"
        let imgData = sut.downloadImage(from: URL(string: urlStr)!)
        XCTAssertNotNil(imgData)
    }
    
    func testUnwrapJSON() {
        if let path = Bundle.main.path(forResource: "MarvelResponse", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                sut.unwrapJson(data: jsonResult)
                XCTAssertEqual(sut.resultHeros[0].name, "Zzzax")
              } catch {
                   // handle error
              }
        }
    }
}
