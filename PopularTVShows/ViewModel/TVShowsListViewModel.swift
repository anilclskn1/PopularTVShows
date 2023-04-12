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
    var tvShows: [TVListResult] = []
    private var favoriteTVShows: [TVListResult] = []
    
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
                self.tvShows.append(contentsOf: response.results!)
                self.totalPages = response.totalPages ?? 0
                self.currentPage += 1
                self.delegate?.didLoadTVShows()
            case .failure(let error):
                self.delegate?.didFailToLoadTVShows(error: error)
            }
        }
    }
    
    func loadMoreTVShows() {
        guard !apiClient.isPaginating else { return }
        guard !isLoading, currentPage <= totalPages else { return }
        isLoading = true
        apiClient.getPopularTVShows(pagination: true, page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.tvShows.append(contentsOf: response.results!)
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
                self.tvShows = response.results!
                self.totalPages = response.totalPages ?? 0
                self.currentPage = 2
                self.delegate?.didRefreshTVShows()
            case .failure(let error):
                self.delegate?.didFailToLoadTVShows(error: error)
            }
        }
    }
    
    func getTVShow(at index: Int) -> TVListResult {
        return tvShows[index]
    }
    
    func isTVShowFavorite(_ tvShow: TVListResult) -> Bool {
        return favoriteTVShows.contains { $0.id == tvShow.id }
    }

    
    func addToFavorites(_ tvShow: TVListResult) {
        favoriteTVShows.append(tvShow)
        dataRepository.saveFavoriteTVShow(tvShow)
    }
    
    func removeFromFavorites(_ tvShow: TVListResult) {
        guard let index = favoriteTVShows.firstIndex(where: { $0.id == tvShow.id }) else { return }
        favoriteTVShows.remove(at: index)
        dataRepository.deleteFavoriteTVShow(tvShow)
    }

    
    func getTVShowsCount() -> Int {
        return tvShows.count
    }
    
}
