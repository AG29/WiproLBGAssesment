//
//  ArtistViewModelTests.swift
//  SearchFMWiproTests
//
//  Created by AG on 11/01/24.
//  Copyright © 2024 AG. All rights reserved.
//

import XCTest

@testable import SearchFMWipro

final class ViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testViewModelArtist() throws {
        let artistViewModel = ArtistViewModel()
        
        XCTAssertNotNil(artistViewModel, "The Artist view model should not be nil.")
        XCTAssertNotNil(artistViewModel.artistCount, "The Artist count should not be nil.")
    }
    
    func testViewModelAlbum() throws {
        let albumViewModel = AlbumViewModel()
        
        XCTAssertNotNil(albumViewModel, "The Album view model should not be nil.")
        XCTAssertNotNil(albumViewModel.albumCount, "The Album count should not be nil.")
    }
    
    func testViewModelTrack() throws {
        let trackViewModel = TrackViewModel()
        
        XCTAssertNotNil(trackViewModel, "The Track view model should not be nil.")
        XCTAssertNotNil(trackViewModel.trackCount, "The Track count should not be nil.")
    }
    
}
