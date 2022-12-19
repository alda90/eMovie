//
//  Movie.swift
//  EMovie
//
//  Created by Aldair Carrillo on 17/12/22.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable {
    let page: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
//        case dates
        case page
        case movies = "results"
    }
}

// MARK: - Result
struct Movie: Codable, Hashable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    private static let baseURLImageString = "https://image.tmdb.org/t/p/w500"
    
    func posterPathURL() -> URL? {
        let urlString = "\(Movie.baseURLImageString)\(posterPath)"
        
        guard let url = URL(string: urlString) else { return nil }
        
        return url
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    static func == (lhs: Movie, rhs: Movie) -> Bool {
      return lhs.identifier == rhs.identifier
    }

    private let identifier = UUID()
    
}
