//
//  ViewController.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 11.04.2023.
//

import UIKit
import Swinject



class ViewController: UIViewController {
    
    private var viewModel: TVShowsListViewModel!
       let container = Container()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       /* let apiClient = APIClient(baseURL: URL(string: "https://api.themoviedb.org/3")!)
        let tvShowsRepository = TVShowsRepository()
        let viewModel = TVShowsListViewModel(apiClient: apiClient, dataRepository: tvShowsRepository)
        
        viewModel.delegate = self
        viewModel.loadTVShows()*/

        container.register(APIClient.self) { _ in
            APIClient(baseURL: URL(string: "https://api.themoviedb.org/3")!)
               }
               
               container.register(TVShowsRepository.self) { _ in
                   TVShowsRepository()
               }
               
               container.register(TVShowsListViewModel.self) { r in
                   let apiClient = r.resolve(APIClient.self)!
                   let dataRepository = r.resolve(TVShowsRepository.self)!
                   let viewModel = TVShowsListViewModel(apiClient: apiClient, dataRepository: dataRepository)
                   viewModel.delegate = self
                   return viewModel
               }
               
               viewModel = container.resolve(TVShowsListViewModel.self)!
        viewModel.loadTVShows()

    }


}

extension ViewController: TVShowsListViewModelDelegate {
    func didLoadMoreTVShows() {
        
    }
    
    func didRefreshTVShows() {
        
    }
    
    func didFailToLoadTVShows(error: Error) {
        print(error.localizedDescription)
    }
    
    func didLoadTVShows() {
        print("a")
    }
    
    // Implement other delegate methods as needed
}

