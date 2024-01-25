//
//  TrackViewModel.swift
//  SearchFMWipro
//
//  Created by Ashish Gore on 11/01/24.
//  Copyright © 2024 AG. All rights reserved.
//

import Foundation

struct TrackViewModel {
    
    private let viewModelHandler = LastFMSearchTableViewModelHandler.sharedInstance
    
    public func getTrack(searchString: String,
                         completion: ((_ success:Bool) -> Void)?) {
        viewModelHandler.getTrack(searchString: searchString) { (success) in
            completion?(success)
        }
    }
    
    public func getTrackDetail(trackName: String, artistName: String,
                             completion: ((_ success:Bool) -> Void)?) {
        self.viewModelHandler.getTrackDetail(trackName: trackName, artistName: artistName) { (success) in
            completion?(success)
      }
    }
    
    public func cellViewModelTrack(index: Int) -> LastFMTableCellTrackModel? {
        return viewModelHandler.cellViewModelTrack(index: index)
       }
    
    public func viewModelTrackDetail() -> DetailViewModelTrack? {
        return viewModelHandler.viewModelTrackDetail()
    }
    
    public var trackCount: Int {
        return viewModelHandler.trackCount
    }
}
