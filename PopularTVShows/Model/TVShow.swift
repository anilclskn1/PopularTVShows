//
//  TVShow.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 12.04.2023.
//

import Foundation

struct TVListResponse: Codable {
    let page: Int?
    let results: [TVListResult]?
    let totalResults: Int?
    let totalPages: Int?

  
}

struct TVListResult: Codable{
    let posterPath: String?
    let popularity: Double?
    let id: Int?
    let backdropPath: String?
    let voteAverage: Double?
    let overview: String?
    let firstAirDate: String?
    let originCountry: [String]?
    let genreIds: [Int]?
    let originalLanguage: String?
    let voteCount: Int?
    let name: String?
    let originalName: String?
    

}


