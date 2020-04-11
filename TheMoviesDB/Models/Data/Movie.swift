//
//  Movie.swift
//  TheMovieDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    private static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/")!
    
     let id: Int?
     let title: String?
     let backdropPath: String?
     let posterPath: String?
     let overview: String?
     let releaseDate: String?
     let voteAverage: Double?
     let voteCount: Int?
     let genres: [Int]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterPath = "poster_path"
        case overview = "overview"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case genres = "genre_ids"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
       
    }
    
    var backdropImageUrl: URL? {
        let imageUrl = Movie.imageBaseURL
        .appendingPathComponent("w780")
        .appendingPathComponent(backdropPath ?? "")
        return imageUrl
    }
    
    var posterImageUrl :URL? {
        let imageUrl = Movie.imageBaseURL
        .appendingPathComponent("w780")
        .appendingPathComponent(posterPath ?? "")
        return imageUrl
    }
    
    var publishYear : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let date = dateFormatter.date(from: releaseDate ?? "") ?? Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return "\(year)"
    }
    
    var formatedDate : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let date = dateFormatter.date(from: releaseDate ?? "") ?? Date()
        dateFormatter.dateFormat = "MMM yyyy"
        return  dateFormatter.string(from: date)
    }
    
    var rating : String {
        if let rating = voteAverage{
            return "⭐️ \(rating)"
        }
        return ""
    }
    
    
}


