//
//  TVShow.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 12.04.2023.
//

import Foundation

struct TVShow: Codable, Equatable {
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?

    static func == (lhs: TVShow, rhs: TVShow) -> Bool {
        return lhs.id == rhs.id
    }
}


struct TVShowsResponse: Decodable {
    let tvShows: [TVShow]
    let totalPages: Int

    private enum CodingKeys: String, CodingKey {
        case tvShows = "results"
        case totalPages = "total_pages"
    }
}
