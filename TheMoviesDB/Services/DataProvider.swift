//
//  DataProvider.swift
//  TheMovieDB
//
//  Created by Yael Bilu Eran on 11/04/2020.
//  Copyright © 2020 CodeQueen. All rights reserved.
//

import Foundation

public class DataProvider :APIClient {
    let session: URLSession
    public static let shared = DataProvider()
    private let apiKey = "04b74cf6a9383cb084b449e8716b4d1e"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func fetchMovies(_ page:Int ,completion: @escaping (Result<[Movie]?, APIError>) -> Void) {
        
        var urlComponents = URLComponents(string: "\(baseAPIURL)/movie/popular")
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                          URLQueryItem(name: "page", value: "\(page)")]
        urlComponents?.queryItems = queryItems
        
        fetch(with: urlComponents?.url , decode: { json -> MoviesResponse? in
            guard let movieFeedResult = json as? MoviesResponse else { return  nil }
            return movieFeedResult
        }, completion: {result  in
            switch result{
            case .success(let moviesResponse):
                completion(Result.success(moviesResponse.results))
            case .failure(let error):
                completion(Result.failure(error))
            }
        })
    }
    
    func fetchMovieVideos(_ id: Int, completion: @escaping (Result<[MovieVideo]?, APIError>) -> Void) {
        
        var urlComponents = URLComponents(string: "\(baseAPIURL)/movie/\(id)/videos")
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents?.queryItems = queryItems
        
        fetch(with: urlComponents?.url , decode: { json -> MovieVideoResponse? in
            guard let vedioResult = json as? MovieVideoResponse else { return  nil }
            return vedioResult
        }, completion: {result  in
            switch result{
            case .success(let movieVideoResponse):
                completion(Result.success(movieVideoResponse.results))
            case .failure(let error):
                completion(Result.failure(error))
            }
        })
    }
    
    func fetchGenres(completion: @escaping (Result<GenreResponse?, APIError>) -> Void) {
        
        var urlComponents = URLComponents(string: "\(baseAPIURL)/genre/movie/list")
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents?.queryItems = queryItems
        
        fetch(with: urlComponents?.url , decode: { json -> GenreResponse? in
            guard let genreResult = json as? GenreResponse else { return  nil }
            return genreResult
        }, completion: completion)
    }
    
}

    
    
    
    
    
   
    

