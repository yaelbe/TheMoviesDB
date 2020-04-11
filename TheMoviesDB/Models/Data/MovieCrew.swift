//
//  MovieCrew.swift
//  TheMovieDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import Foundation

public struct MovieCrew: Codable {
    public let id: Int
    public let department: String
    public let job: String
    public let name: String
}
