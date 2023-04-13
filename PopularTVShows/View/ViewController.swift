//
//  ViewController.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 11.04.2023.
//

import UIKit
import Swinject
import SDWebImage

class ViewController: UIViewController {
    
    private var viewModel: TVShowsListViewModel!
    let container = Container()
    var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        container.register(APIClient.self) { _ in
            APIClient(baseURL: URL(string: "https://api.themoviedb.org/3")!, apiKey: "eec13a24107da841b9dbd0efa01346bf")
        }
        
        container.register(TVShowsRepository.self) { _ in
            TVShowsRepository()
        }
        
        container.register(TVShowsListViewModel.self) { r in
            let dataRepository = r.resolve(TVShowsRepository.self)!
            let apiClient = r.resolve(APIClient.self)!
            let viewModel = TVShowsListViewModel(apiClient: apiClient, dataRepository: dataRepository)
            viewModel.delegate = self
            return viewModel
        }
        
        viewModel = container.resolve(TVShowsListViewModel.self)!
        viewModel.loadTVShows()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TVShowCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)

    }
    
    private func createSpinnerFooter() -> UIView{
        let footerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: Int(view.frame.size.width),
                                              height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
}

extension ViewController: TVShowsListViewModelDelegate {
    func didLoadMoreTVShows() {
      
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }



    
    func didRefreshTVShows() {
      
    }
    
    func didFailToLoadTVShows(error: Error) {
        print(error.localizedDescription)
    }
    
    func didLoadTVShows() {
            // Do something with the list of TV shows
      
     
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTVShowsCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TVShowCell
        let show = viewModel.getTVShow(at: indexPath.row)
        cell.titleLabel.text = show.name
        cell.showImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w92\(show.posterPath ?? "")"))
        cell.ratingLabel.text = "Rating: \(show.voteAverage?.formatted() ?? "")/10"
        cell.favoriteIcon.isHidden = true
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height{
            //fetch more data
            self.tableView.tableFooterView = createSpinnerFooter()
            viewModel.loadMoreTVShows()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = viewModel.tvShows[indexPath.row]
        let vc = DetailsViewController()
        vc.selectedID = selectedItem.id ?? -1
        vc.selectedTitle = selectedItem.name ?? ""
        vc.selectedImageURL = "https://image.tmdb.org/t/p/w500\(selectedItem.posterPath ?? "")"
        present(vc, animated: true)
    }
}
