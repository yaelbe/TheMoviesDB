//
//  MovieVideoResponse.swift
//  TheMovieDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import Foundation
public struct MovieVideoResponse: Codable {
    public let results: [MovieVideo]
}
