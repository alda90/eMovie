//
//  NetworkRouter.swift
//  EMovie
//
//  Created by Aldair Carrillo on 17/12/22.
//

import Foundation

enum NetworkRouter {
    case getUpcomings
    case getTopRated
    case getPopular
    case getVideos(id: Int)
    
    private static let baseURLString = "https://api.themoviedb.org/3/movie"
    private static let apiKey = "608cfab9393cf6de1a420e80a1c19ffb"
    
    private enum HTTTPMethod {
        case get
        case post
        
        var value: String {
            switch self {
            case .get: return "GET"
            case .post: return "POST"
            }
        }
    }
    
    private var method: HTTTPMethod {
        switch self {
        case .getUpcomings: return .get
        case .getTopRated: return .get
        case .getPopular: return .get
        case .getVideos: return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getUpcomings:
            return "/upcoming"
        case .getTopRated:
            return "/top_rated"
        case .getPopular:
            return "/popular"
        case .getVideos(let id):
            return "/\(id)/videos"
        }
    }
    
    func request() throws -> URLRequest {
        let urlString = "\(NetworkRouter.baseURLString)\(path)"
        
        guard let baseURL = URL(string: urlString),
              var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
                else { throw NetworkErrorType.parseUrlFail }
    
        components.queryItems = [URLQueryItem(name: "api_key", value: NetworkRouter.apiKey)]
        
        guard let url = components.url else { throw NetworkErrorType.parseUrlFail }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
