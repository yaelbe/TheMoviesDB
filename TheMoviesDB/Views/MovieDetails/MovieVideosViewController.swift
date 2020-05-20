//
//  MovieVideosViecController.swift
//  TheMoviesDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import XCDYouTubeKit

class MovieVideosViecController: UICollectionViewController{
    
    private var cancelSubscription: CancelSubscription?
    var viewModel: BaseViewModel<MovieVideo>!
    var movie : Movie!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trailers"
        collectionView.register(VideoCell.nib, forCellWithReuseIdentifier: VideoCell.identifier)
        collectionView.register(TrailersHeader.self,forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        cancelSubscription = viewModel.state.subscribe(on: .main) { [weak self] state in
            self?.handle(state)
        }
        viewModel.onSelectItem = { [weak self] video in
            self?.playVideo(video.key)
        }
        viewModel.loadNextPage()
    }
    
    deinit {
        cancelSubscription?()
    }
    
    private func playVideo(_ key: String){
        XCDYouTubeClient.default().getVideoWithIdentifier(key){[weak self] video,error in
            if error != nil { return }
            if let videoURL = video?.streamURL {
                let player = AVPlayer(url: videoURL)
                let playerController = AVPlayerViewController()
                playerController.player = player
                self?.present(playerController, animated: true) {
                    playerController.player?.play()
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? TrailersHeader
            sectionHeader?.configure(movie: movie)
            return sectionHeader ?? UICollectionReusableView()
        } else { //No footer in this case but can add option for that
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.identifier, for: indexPath) as? VideoCell{
            let video = viewModel.data(at: indexPath.row)
            cell.video = video
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.selectItem(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    }
    
    
    /// Changes the representation regarding the view model state
    func handle(_ state: State) {
        switch state {
            
        case .loading, .empty:
            collectionView.isHidden = true
            
        case .fatalError(let message):
            collectionView.isHidden = true
            
            let alert = UIAlertController(
                title: "ERROR",
                message: message,
                preferredStyle: .alert
            )
            present(alert, animated: true)
            
        case .data:
            collectionView.isHidden = false
            collectionView.reloadData()
        default: break
        }
    }
}

extension MovieVideosViecController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = UIScreen.main.bounds.width - 20
        let itemHeight = itemWidth * 0.2
        return CGSize(width: itemWidth  , height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

