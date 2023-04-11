//
//  TVShowsListViewModel.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 12.04.2023.
//

import Foundation

protocol TVShowsListViewModelDelegate: AnyObject {
    func didLoadTVShows()
    func didLoadMoreTVShows()
    func didRefreshTVShows()
    func didFailToLoadTVShows(error: Error)
}

class TVShowsListViewModel {
    
    private let apiClient: APIClient
    private let dataRepository: TVShowsRepository
    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    private var isRefreshing = false
    private var tvShows: [TVShow] = []
    private var favoriteTVShows: [TVShow] = []
    
    weak var delegate: TVShowsListViewModelDelegate?
    
    init(apiClient: APIClient, dataRepository: TVShowsRepository) {
        self.apiClient = apiClient
        self.dataRepository = dataRepository
    }
    
    func loadTVShows() {
        guard !isLoading else { return }
        isLoading = true
        apiClient.getPopularTVShows(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.tvShows.append(contentsOf: response.tvShows)
                self.totalPages = response.totalPages
                self.currentPage += 1
                self.delegate?.didLoadTVShows()
            case .failure(let error):
                self.delegate?.didFailToLoadTVShows(error: error)
            }
        }
    }
    
    func loadMoreTVShows() {
        guard !isLoading, currentPage <= totalPages else { return }
        isLoading = true
        apiClient.getPopularTVShows(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.tvShows.append(contentsOf: response.tvShows)
                self.currentPage += 1
                self.delegate?.didLoadMoreTVShows()
            case .failure(let error):
                self.delegate?.didFailToLoadTVShows(error: error)
            }
        }
    }
    
    func refreshTVShows() {
        guard !isRefreshing else { return }
        isRefreshing = true
        apiClient.getPopularTVShows(page: 1) { [weak self] result in
            guard let self = self else { return }
            self.isRefreshing = false
            switch result {
            case .success(let response):
                self.tvShows = response.tvShows
                self.totalPages = response.totalPages
                self.currentPage = 2
                self.delegate?.didRefreshTVShows()
            case .failure(let error):
                self.delegate?.didFailToLoadTVShows(error: error)
            }
        }
    }
    
    func getTVShow(at index: Int) -> TVShow {
        return tvShows[index]
    }
    
    func isTVShowFavorite(_ tvShow: TVShow) -> Bool {
        return favoriteTVShows.contains(tvShow)
    }
    
    func addToFavorites(_ tvShow: TVShow) {
        favoriteTVShows.append(tvShow)
        dataRepository.saveFavoriteTVShow(tvShow)
    }
    
    func removeFromFavorites(_ tvShow: TVShow) {
        guard let index = favoriteTVShows.firstIndex(of: tvShow) else { return }
        favoriteTVShows.remove(at: index)
        dataRepository.deleteFavoriteTVShow(tvShow)
    }
    
    func getTVShowsCount() -> Int {
        return tvShows.count
    }
    
}
