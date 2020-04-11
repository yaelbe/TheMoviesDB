//
//  GenreListData.swift
//  TheMoviesDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import Foundation

class GenreViewModel: BaseViewModel<MovieGenre>{
    override func load()  {
        DataProvider.shared.fetchGenres{ [weak self] result in
            switch result {
            case .success(let genres):
                guard let movieGenres = genres?.genres else { return }
                self?.add(data: movieGenres)
            case .failure(let error):
                print("the error \(error)")
            }
        }
        
    }
}
