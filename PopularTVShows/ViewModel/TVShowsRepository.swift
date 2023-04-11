//
//  TVShowsRepository.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 12.04.2023.
//

import Foundation

class TVShowsRepository {
    
    private let userDefaults: UserDefaults
    private let favoriteTVShowsKey = "favoriteTVShows"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func saveFavoriteTVShow(_ tvShow: TVShow) {
        var favoriteTVShows = getFavoriteTVShows()
        favoriteTVShows.append(tvShow)
        saveFavoriteTVShows(favoriteTVShows)
    }
    
    func deleteFavoriteTVShow(_ tvShow: TVShow) {
        var favoriteTVShows = getFavoriteTVShows()
        guard let index = favoriteTVShows.firstIndex(of: tvShow) else { return }
        favoriteTVShows.remove(at: index)
        saveFavoriteTVShows(favoriteTVShows)
    }
    
    func getFavoriteTVShows() -> [TVShow] {
        guard let data = userDefaults.data(forKey: favoriteTVShowsKey) else { return [] }
        guard let favoriteTVShows = try? PropertyListDecoder().decode([TVShow].self, from: data) else { return [] }
        return favoriteTVShows
    }
    
    private func saveFavoriteTVShows(_ favoriteTVShows: [TVShow]) {
        guard let data = try? PropertyListEncoder().encode(favoriteTVShows) else { return }
        userDefaults.set(data, forKey: favoriteTVShowsKey)
    }
    
}
