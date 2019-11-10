//
//  RoversTests.swift
//  RoversTests
//
//  Created by Peter Irving on 11/10/19.
//  Copyright © 2019 Peter Irving. All rights reserved.
//

import XCTest
@testable import Rovers

class RoversTests: XCTestCase {


    func testGetUrlReturnsNilWithNilRover() {
        let rover: String? = nil
        let url: URL? = NetworkingClient.shared.getURL(rover: rover)
        XCTAssertNil(url)
    }
    
    func testGetURLReturnsProperURL() {
        let rover = "curiosity"
        let url: URL = NetworkingClient.shared.getURL(rover: rover)!
        
        XCTAssertEqual(url, URL(string:"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1001&page=1&api_key=\(apiKey)"))
    }
    
    func testGetExpectedImage() {
        let cell = RoverCell()
        let image = cell.getImageName(roverName: "Curiosity")
        XCTAssertEqual(UIImage(named: "resize_curiosity"), image)
    }
    
    func testGetNilImageWithIncorrectRoverName() {
        let cell = RoverCell()
        let image = cell.getImageName(roverName: "Earl Scruggs")
        XCTAssertNil(image)
    }

}
