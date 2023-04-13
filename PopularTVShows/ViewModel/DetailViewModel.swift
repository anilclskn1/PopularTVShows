//
//  DetailViewModel.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 13.04.2023.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func didLoadDetails()
    func didFailToLoadDetails(error: Error)
}

class DetailViewModel {
    
    private let detailAPIClient: DetailAPIClient
    var tvShowDetail = TVShowDetailsResponse(
        backdropPath: "/example-backdrop-path.jpg",
        createdBy: [
            CreatedBy(
                id: 123,
                creditId: "example-credit-id",
                name: "Example Creator",
                gender: 1,
                profilePath: "/example-creator-profile.jpg"
            )
        ],
        id: 456,
        creditId: "example-credit-id",
        name: "Example TV Show",
        gender: 1,
        profilePath: "/example-profile.jpg",
        episodeRunTime: [30, 45],
        firstAirDate: "2021-01-01",
        genres: [
            Genre(id: 1, name: "Comedy"),
            Genre(id: 2, name: "Drama")
        ],
        homepage: "https://example.com",
        inProduction: true,
        languages: ["en", "es"],
        lastAirDate: "2021-12-31",
        lastEpisodeToAir: LastEpisodeToAir(
            airDate: "2021-12-31",
            episodeNumber: 10,
            id: 789,
            name: "Example Last Episode",
            overview: "This is the last episode",
            productionCode: "example-production-code",
            seasonNumber: 1,
            stillPath: "/example-still-path.jpg",
            voteAverage: 8.5,
            voteCount: 100
        ),
        originCountry: ["US"],
        originalLanguage: "en",
        originalName: "Example Original TV Show Name",
        overview: "This is an example TV show",
        popularity: 7.8,
        posterPath: "/example-poster-path.jpg",
        productionCompanies: [
            ProductionCompany(
                id: 111,
                logoPath: "/example-logo-path.jpg",
                name: "Example Production Company",
                originCountry: "US"
            )
        ],
        productionCountries: [
            ProductionCountry(
                iso31661: "US",
                name: "United States of America"
            )
        ],
        seasons: [
            Season(
                airDate: "2021-01-01",
                episodeCount: -1,
                id: 123,
                name: "Example Season 1",
                overview: "This is the first season",
                posterPath: "/example-season1-poster-path.jpg",
                seasonNumber: -1
            ),
            Season(
                airDate: "2022-01-01",
                episodeCount: 12,
                id: 456,
                name: "Example Season 2",
                overview: "This is the second season",
                posterPath: "/example-season2-poster-path.jpg",
                seasonNumber: -1
            )
        ],
        spokenLanguages: [
            SpokenLanguage(
                englishName: "English",
                iso6391: "en",
                name: "English"
            )
        ],
        status: "Returning Series",
        tagline: "An example TV show",
        type: "Scripted",
        voteAverage: 8.0,
        voteCount: 500
    )

    private let id: Int

    weak var delegate: DetailViewModelDelegate?
    
    init(DetailAPIClient: DetailAPIClient, id: Int) {
        self.detailAPIClient = DetailAPIClient
        self.id = id
    }
    
    func loadDetails() {
        detailAPIClient.getTVShowDetails(tvShowId: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.tvShowDetail.numberOfEpisodes = response.numberOfEpisodes ?? -1
                self.tvShowDetail.numberOfSeasons = response.numberOfSeasons ?? -1
                self.delegate?.didLoadDetails()
            case .failure(let error):
                self.delegate?.didFailToLoadDetails(error: error)
            }
        }
    }
    
    func getGenres() -> [Genre]?{
        return tvShowDetail.genres
    }
    
    func getNumOfEpisodes() -> Int?{
        return tvShowDetail.numberOfEpisodes
    }
    
    func getNumOfSeasons() -> Int?{
        return tvShowDetail.numberOfSeasons
    }
    

    
}
