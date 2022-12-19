//
//  EMovieTests.swift
//  EMovieTests
//
//  Created by Aldair Carrillo on 17/12/22.
//

import XCTest
@testable import EMovie

final class EMovieTests: XCTestCase {

    func testGetUpcomingMovies() {
        let expectation = self.expectation(description: "movies")
            
        var movieResponse: MovieResponse?
        
        NetworkManager.shared.request(networkRouter: NetworkRouter.getUpcomings) { (result: NetworkResult<MovieResponse>) in
            switch result {
            case .success(let movieResp):
                movieResponse = movieResp
            default:
                break
            }
            
            expectation.fulfill()
        }
            
        waitForExpectations(timeout: 10, handler: nil)
            
        XCTAssertNotNil(movieResponse)
    }
    
    func testGetTopRatedMovies() {
        let expectation = self.expectation(description: "movies")
            
        var movieResponse: MovieResponse?
        
        NetworkManager.shared.request(networkRouter: NetworkRouter.getTopRated) { (result: NetworkResult<MovieResponse>) in
            switch result {
            case .success(let movieResp):
                movieResponse = movieResp
            default:
                break
            }
            
            expectation.fulfill()
        }
            
        waitForExpectations(timeout: 10, handler: nil)
            
        XCTAssertNotNil(movieResponse)
    }
    
    func testGetPopularMovies() {
        let expectation = self.expectation(description: "movies")
            
        var movieResponse: MovieResponse?
        
        NetworkManager.shared.request(networkRouter: NetworkRouter.getPopular) { (result: NetworkResult<MovieResponse>) in
            switch result {
            case .success(let movieResp):
                movieResponse = movieResp
            default:
                break
            }
            
            expectation.fulfill()
        }
            
        waitForExpectations(timeout: 10, handler: nil)
            
        XCTAssertNotNil(movieResponse)
    }
    
    func testGetVideosMovie() {
        let id = 436270
        let expectation = self.expectation(description: "videos")
        
        var videoResponse: VideoResponse?
        NetworkManager.shared.request(networkRouter: NetworkRouter.getVideos(id: id)) { (result: NetworkResult<VideoResponse>) in
                switch result {
                case .success(let videoResp):
                    videoResponse = videoResp
                default:
                    break
                }
                
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 10, handler: nil)
            
        XCTAssertEqual(videoResponse?.id, id)
        XCTAssertNotNil(videoResponse)
    }

}
