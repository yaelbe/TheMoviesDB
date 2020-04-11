//
//  MovieVideo.swift
//  TheMovieDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import Foundation

public struct MovieVideo: Codable {
    public let id: String
    public let key: String
    public let name: String
    public let site: String
    public let size: Int
    public let type: String
    
    public var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}
