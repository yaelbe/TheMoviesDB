//
//  VideoViewModel.swift
//  TheMoviesDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import Foundation

class VideoViewModel:BaseViewModel<MovieVideo>{
    var videoId :Int!
    override func load()  {
        DataProvider.shared.fetchMovieVideos(videoId){ [weak self] result in
            switch result {
            case .success(let videos):
                guard let moviesList = videos else { return }
                self?.add(data: moviesList)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
}
