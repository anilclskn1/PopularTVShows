//
//  TVShowsDetail.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 12.04.2023.
//

import Foundation

struct TVShowDetailsResponse: Codable {
    let backdropPath: String?
    let createdBy: [CreatedBy]?
    let id: Int?
    let creditId: String?
    let name: String?
    let gender: Int?
    let profilePath: String?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    var genres: [Genre]?
    let homepage: String?
    let inProduction: Bool?
    let languages: [String]?
    let lastAirDate: String?
    let lastEpisodeToAir: LastEpisodeToAir?
    var numberOfEpisodes: Int?
    var numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalName: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let seasons: [Season]?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let type: String?
    let voteAverage: Double?
    let voteCount: Int?
}

struct CreatedBy: Codable {
    let id: Int?
    let creditId: String?
    let name: String?
    let gender: Int?
    let profilePath: String?
}

struct Genre: Codable {
    let id: Int?
    let name: String?
}

struct LastEpisodeToAir: Codable {
    let airDate: String?
    let episodeNumber: Int?
    let id: Int?
    let name: String?
    let overview: String?
    let productionCode: String?
    let seasonNumber: Int?
    let stillPath: String?
    let voteAverage: Double?
    let voteCount: Int?
}

struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?
}

struct ProductionCountry: Codable {
    let iso31661: String?
    let name: String?
}

struct Season: Codable {
    let airDate: String?
    let episodeCount: Int?
    let id: Int?
    let name: String?
    let overview: String?
    let posterPath: String?
    let seasonNumber: Int?
}

struct SpokenLanguage: Codable {
    let englishName: String?
    let iso6391: String?
    let name: String?
}

