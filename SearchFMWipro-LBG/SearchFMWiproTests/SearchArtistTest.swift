//
//  SearchArtistTest.swift
//  SearchFMWiproTests
//
//  Created by Apple on 10/12/23.
//  Copyright © 2023 AG. All rights reserved.
//

import XCTest
@testable import SearchFMWipro

class SearchArtistTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK:- Happy Dataset
    func testSerialization_artist() {
        let resultModel  = MockData.resultModel(for: .artist)
        XCTAssertNotNil(resultModel)
    }
    
    func testResultModel_artist () {
        let resultModel  = MockData.resultModel(for: .artist)
        let artist = resultModel.first!
        
        XCTAssertNotNil(artist)
        XCTAssertEqual(artist.name, "Justin Timberlake")
        XCTAssertEqual(artist.image.count,  5)
        XCTAssertEqual(artist.url, "https://www.last.fm/music/Justin+Timberlake")

    }
    
    func testArtistSearchAPI() {
        
        let artistViewModel = ArtistViewModel()
        
        XCTAssertNotNil(artistViewModel, "The Artist view model should not be nil.")
        
        let success = true
        var completionResult: Bool?
            // Create an expectation
            let expectation = self.expectation(description: "artist")

        artistViewModel.getArtist(searchString: "justin") { success in
            completionResult = success
            expectation.fulfill()
        }
            waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(completionResult, "The API response should not be nil.")
            XCTAssertEqual(completionResult, success)
            XCTAssertNotNil(artistViewModel.artistCount, "The Artist count should not be nil.")
        }
    
    

}
