//
//  ArtistViewModel.swift
//  SearchFMWipro
//
//  Created by Ashish Gore on 11/01/24.
//  Copyright © 2024 AG. All rights reserved.
//

import Foundation

struct ArtistViewModel {
    
    private let viewModelHandler = LastFMSearchTableViewModelHandler.sharedInstance
    
    public func getArtist(searchString: String,
                             completion: ((_ success:Bool) -> Void)?) {
        viewModelHandler.getArtist(searchString: searchString) { (success) in
            completion?(success)
        }
    }
    
    public func getArtistDetail(artistName: String,
                                completion: ((_ success:Bool) -> Void)?) {
        viewModelHandler.getArtistDetail(artistName: artistName) { (success) in
            completion?(success)
        }
    }
    
    public func cellViewModelArtist(index: Int) -> LastFMTableCellArtistModel? {
        return viewModelHandler.cellViewModelArtist(index: index)
       }
    
    
    public func viewModelArtisDetail() -> DetailViewModelArtist? {
        return viewModelHandler.viewModelArtisDetail()
    }
    
    public var artistCount: Int {
        return viewModelHandler.artistCount
    }
    
    
}
