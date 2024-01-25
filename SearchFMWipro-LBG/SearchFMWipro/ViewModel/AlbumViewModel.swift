//
//  AlbumViewModel.swift
//  SearchFMWipro
//
//  Created by Ashish Gore on 11/01/24.
//  Copyright © 2024 AG. All rights reserved.
//

import Foundation

struct AlbumViewModel {
    
    private let viewModelHandler = LastFMSearchTableViewModelHandler.sharedInstance
    
    public func getAlbum(searchString: String,
                             completion: ((_ success:Bool) -> Void)?) {
        
        viewModelHandler.getAlbum(searchString: searchString) { (success) in
            completion?(success)
              }
    }
    
    public func getAlbumDetail(albumName: String, artistName: String,
                             completion: ((_ success:Bool) -> Void)?) {
        
        viewModelHandler.getAlbumDetail(albumName: albumName, artistName: artistName) { (success) in
            completion?(success)
      }
        
    }

    public func cellViewModelAlbum(index: Int) -> LastFMTableCellAlbumModel? {
        return viewModelHandler.cellViewModelAlbum(index: index)
       }
    
    public func viewModelAlbumDetail() -> DetailViewModelAlbum? {
        return viewModelHandler.viewModelAlbumDetail()
    }
    
    public var albumCount: Int {
        return viewModelHandler.albumCount
    }
}
