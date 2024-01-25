//
//  SearchViewController.swift
//  SearchFMWipro
//
//  Created by AG on 09/12/23.
//  Copyright © 2023 AG. All rights reserved.
//


import UIKit

enum SearchVisibleTab : Int {
    case none
    case albums
    case artists
    case songs
}

class SearchViewController: UIViewController, UIGestureRecognizerDelegate,UITextFieldDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    var visibleTab: SearchVisibleTab!
    var searchString:String?
    @IBOutlet weak var detailView: DetailView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailListnerCountLbl: UILabel!
    @IBOutlet weak var detailPlayCountLbl: UILabel!
    @IBOutlet weak var detailNameLbl: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var indicator: UIView!
    @IBOutlet weak var hiddenArtistNameLbl: UILabel!
    @IBOutlet weak var hiddenAlbumNameLbl: UILabel!
    
    private let artistViewModel = ArtistViewModel()
    private let albumViewModel = AlbumViewModel()
    private let trackViewModel = TrackViewModel()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        indicator.startRotating()
        searchBar.searchTextField.delegate = self
        let segment: UISegmentedControl = UISegmentedControl(items: ["Albums", "Artists","Songs"])
           segment.sizeToFit()
           if #available(iOS 13.0, *) {
               segment.selectedSegmentTintColor = UIColor.red
           } else {
              segment.tintColor = UIColor.red
           }
        segment.selectedSegmentIndex = 0
        visibleTab = .albums
        segment.setTitleTextAttributes([NSAttributedString.Key.font :UIFont.systemFont(ofSize: 15)], for: .normal)
           self.navigationItem.titleView = segment
        
        segment.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gestureRecognizer.delegate = self
        gestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(gestureRecognizer)
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        searchTableView.allowsSelection = true
    }

    
    func callSearchAPIs() {
    showLoader()
    searchString = searchBar.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if let search = searchString, search != "" {
            
            albumViewModel.getAlbum(searchString: search) { (success) in
                if self.visibleTab == .albums {
                    if (success) {
                        DispatchQueue.main.async {
                            self.hideLoader()
                            self.searchTableView.reloadData()
                        }
                    } else {
                        self.showError()
                    }
                }
                  }
            trackViewModel.getTrack(searchString: search) { (success) in
                if self.visibleTab == .songs {
                    if (success) {
                        DispatchQueue.main.async {
                            self.hideLoader()
                            self.searchTableView.reloadData()
                        }
                    } else {
                        self.showError()
                    }
                }
                   }
                   
            artistViewModel.getArtist(searchString: search) { (success) in
                if self.visibleTab == .artists {
                    if(success) {
                        DispatchQueue.main.async {
                            self.hideLoader()
                            self.searchTableView.reloadData()
                        }
                    } else
                    {
                        self.showError()
                    }
                }
            }
        } else {
            self.hideLoader()
        }
        
    }
    
    func showLoader() {
        self.view.bringSubviewToFront(self.indicator.superview!)
    }
    
    func hideLoader() {
         self.view.sendSubviewToBack(self.indicator.superview!)
    }
    
    @objc func hideKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    
 @objc func segmentControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            visibleTab = .albums
        } else if sender.selectedSegmentIndex == 1 {
            visibleTab = .artists
        } else {
            visibleTab = .songs
        }
        resetDetail()
        searchTableView.reloadData()
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        callSearchAPIs()
        return true
    }
    
}

  // MARK: -
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
      // MARK: -
      // MARK: UITableView delegate methods
      
      
    func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if visibleTab == .artists {
          return artistViewModel.artistCount
      } else if visibleTab == .albums {
          return albumViewModel.albumCount
      } else if visibleTab == .songs {
          return trackViewModel.trackCount
      }
      return 0
      
      }
      
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          if visibleTab == .artists {
              guard let cell = tableView.dequeueReusableCell(withIdentifier: LastFMArtistTableCell.reuseIdentifier,
                                                             for: indexPath) as? LastFMArtistTableCell else {
                  return UITableViewCell()
              }

              let cellViewModel = artistViewModel.cellViewModelArtist(index: indexPath.row)
              cell.viewModel = cellViewModel

              return cell
          } else if visibleTab == .albums {
              guard let cell = tableView.dequeueReusableCell(withIdentifier: LastFMAlbumTableCell.reuseIdentifier,
                                                             for: indexPath) as? LastFMAlbumTableCell else {
                  return UITableViewCell()
              }

              let cellViewModel = albumViewModel.cellViewModelAlbum(index: indexPath.row)
              cell.viewModel = cellViewModel

              return cell
          } else if visibleTab == .songs {
              guard let cell = tableView.dequeueReusableCell(withIdentifier: LastFMTrackTableCell.reuseIdentifier,
                                                             for: indexPath) as? LastFMTrackTableCell else {
                  return UITableViewCell()
              }

              let cellViewModel = trackViewModel.cellViewModelTrack(index: indexPath.row)
              cell.viewModel = cellViewModel

              return cell
          }
          return UITableViewCell()
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
          
          if visibleTab == .artists {
          if let cellViewModel = artistViewModel.cellViewModelArtist(index: indexPath.row) {
            DispatchQueue.main.async {
                self.showLoader()
                self.artistViewModel.getArtistDetail(artistName: cellViewModel.name) { (success) in
                    if(success) {
                  self.loadArtistDetail()
                    }
                    else {
                        self.showError()
                    }
              }
            }
          }
              
          } else if visibleTab == .albums {
              if let cellViewModel = albumViewModel.cellViewModelAlbum(index: indexPath.row) {
                DispatchQueue.main.async {
                    self.showLoader()
                    self.albumViewModel.getAlbumDetail(albumName: cellViewModel.name, artistName: cellViewModel.artist) { (success) in
                        if(success) {
                      self.loadAlbumDetail()
                        } else {
                            self.showError()
                        }
                  }
                }
              }
              
          } else if visibleTab == .songs {
              if let cellViewModel = trackViewModel.cellViewModelTrack(index: indexPath.row) {
                DispatchQueue.main.async {
                    self.showLoader()
                    self.trackViewModel.getTrackDetail(trackName: cellViewModel.name, artistName: cellViewModel.artist) { (success) in
                        if(success) {
                        self.loadTrackDetail()
                        } else
                        {
                            self.showError()
                        }
                  }
              }
            }
          }
      }
      
      func loadArtistDetail() {
          
        if let detailViewModel = self.artistViewModel.viewModelArtisDetail() {
        DispatchQueue.main.async {
          self.detailImageView.downloadImage(url: detailViewModel.artistMegaImagePath)
          self.detailNameLbl.text = detailViewModel.name
          self.detailListnerCountLbl.text = detailViewModel.listnerCount
          self.detailPlayCountLbl.text = detailViewModel.playCount
          self.detailView.isHidden = false
          self.blurView.isHidden = false
          self.hideLoader()
          }
        }
          
      }
      
      func loadAlbumDetail() {
          
        if let detailViewModel = self.albumViewModel.viewModelAlbumDetail() {
            DispatchQueue.main.async {
            self.detailImageView.downloadImage(url: detailViewModel.albumLargeImagePath)
            self.detailNameLbl.text = detailViewModel.name
            self.detailListnerCountLbl.text = detailViewModel.listnerCount
            self.detailPlayCountLbl.text = detailViewModel.playCount
            self.detailView.isHidden = false
            self.blurView.isHidden = false
            self.hideLoader()
            }
        }
      }
      
      func loadTrackDetail() {
          
        if let detailViewModel = self.trackViewModel.viewModelTrackDetail() {
        DispatchQueue.main.async {
            self.detailImageView.downloadImage(url: detailViewModel.trackAlbumLargeImagePath )
            self.detailNameLbl.text = detailViewModel.name
            self.detailListnerCountLbl.text = detailViewModel.listnerCount
            self.detailPlayCountLbl.text = detailViewModel.playCount
            self.hiddenArtistNameLbl.text = detailViewModel.artist
            self.hiddenAlbumNameLbl.text = detailViewModel.album
            self.hiddenAlbumNameLbl.isHidden = false
            self.hiddenArtistNameLbl.isHidden = false
            self.detailView.isHidden = false
            self.blurView.isHidden = false
            self.hideLoader()
            }
            
        }
          
      }
    
    @IBAction func returnButton(_ sender: Any) {
        resetDetail()
    }
    
    func resetDetail() {
        self.detailImageView.image = nil
        self.detailNameLbl.text = ""
        self.detailListnerCountLbl.text = ""
        self.detailPlayCountLbl.text = ""
        self.hiddenAlbumNameLbl.text = ""
        self.hiddenArtistNameLbl.text = ""
        self.detailView.isHidden = true
        self.blurView.isHidden = true
        self.hiddenAlbumNameLbl.isHidden = true
        self.hiddenArtistNameLbl.isHidden = true
        hideLoader()
    }
    
    func showError()
    {
        
        if Thread.isMainThread {
            let alert = UIAlertController(title: Constants.Alert.alertErrorTitle, message: Constants.Alert.alertErrorMessage,         preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: Constants.Alert.alertOK, style: UIAlertAction.Style.default, handler: { _ in
                self.resetDetail()
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: Constants.Alert.alertErrorTitle, message: Constants.Alert.alertErrorMessage,         preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: Constants.Alert.alertOK, style: UIAlertAction.Style.default, handler: { _ in
                    self.resetDetail()
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
