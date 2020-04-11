//
//  MoviesListData.swift
//  TheMoviesDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import Foundation

class MoviesViewModel:BaseViewModel<Movie>{
    var lastPage: Int {
           return lock.sync { return self._lastPage }
       }
    
    private var _lastPage: Int = 1
    
    override func load()  {
        DataProvider.shared.fetchMovies(_lastPage){ [weak self] result in
            switch result {
            case .success(let movies):
                guard let moviesList = movies else { return }
                self?.add(data: moviesList)
                self?.lock.sync {self?._lastPage+=1}
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
}
