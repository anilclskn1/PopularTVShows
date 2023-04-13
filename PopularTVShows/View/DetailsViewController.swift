//
//  DetailsViewController.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 12.04.2023.
//

import UIKit
import SDWebImage
import Swinject

class DetailsViewController: UIViewController {
    
    private var viewModel: DetailViewModel!
    private var favoriteViewModel: TVShowsRepository!
    let container = Container()
    var isFavorite: Bool = false
    var selectedID = -1
    var selectedTitle = ""
    var selectedImageURL = ""
    //var selectedTVShow =  TVListResult(posterPath: "", popularity: 0.0, id: 0, backdropPath: "", voteAverage: 0.0, overview: "", firstAirDate: "", originCountry: [], genreIds: [], originalLanguage: "", voteCount: 0, name: "", originalName: "")


    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "Title"
        label.textAlignment = .center
        return label
    }()
    
    let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let showImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .actions
        return imageView
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let seasonsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .lightText
        label.textAlignment = .center
        return label
    }()
    
    let episodesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .lightText
        label.textAlignment = .center
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Add Favorite", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        print(selectedID)
        container.register(DetailAPIClient.self) { _ in
            DetailAPIClient(baseURL: URL(string: "https://api.themoviedb.org")!, apiKey: "eec13a24107da841b9dbd0efa01346bf")
        }
        
        
        container.register(DetailViewModel.self) { r in
            let apiClient = r.resolve(DetailAPIClient.self)!

            let viewModel = DetailViewModel(DetailAPIClient: apiClient, id: self.selectedID)
            viewModel.delegate = self
            return viewModel
        }
        
        viewModel = container.resolve(DetailViewModel.self)!
        viewModel.loadDetails()
        
        
        container.register(TVShowsRepository.self) { r in
            let viewModel = TVShowsRepository(userDefaults: .standard)
            return viewModel
        }
        
        favoriteViewModel = container.resolve(TVShowsRepository.self)!
        print(favoriteViewModel.getFavoriteTVShows())
        
    }
    
    @objc func didTapFavorite(){
        //favoriteViewModel.saveFavoriteTVShow(selectedTVShow)
        //print(favoriteViewModel.getFavoriteTVShows())
    }

 
        
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(showImageView)
        view.addSubview(genreLabel)
        view.addSubview(seasonsLabel)
        view.addSubview(episodesLabel)
        view.addSubview(favoriteButton)
        view.addSubview(bgImageView)
        view.bringSubviewToFront(titleLabel)
        view.bringSubviewToFront(showImageView)
        view.bringSubviewToFront(seasonsLabel)
        view.bringSubviewToFront(episodesLabel)
        view.bringSubviewToFront(favoriteButton)
        view.bringSubviewToFront(genreLabel)

        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        showImageView.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        seasonsLabel.translatesAutoresizingMaskIntoConstraints = false
        episodesLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = selectedTitle
        showImageView.sd_setImage(with: URL(string: selectedImageURL))
        bgImageView.frame = view.bounds
        bgImageView.sd_setImage(with: URL(string: selectedImageURL))
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bgImageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)


        bgImageView.addSubview(blurEffectView)
        
        let constraints = [
            showImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            showImageView.widthAnchor.constraint(equalToConstant: 200),
            showImageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: showImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            genreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            genreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            seasonsLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 16),
            seasonsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            seasonsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            episodesLabel.topAnchor.constraint(equalTo: seasonsLabel.bottomAnchor, constant: 16),
            episodesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            episodesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            favoriteButton.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor, constant: 40),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 200),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension DetailsViewController: DetailViewModelDelegate{
    func didLoadDetails() {
        if let numOfEpisodes = viewModel.getNumOfEpisodes(),
           let numOfSeasons = viewModel.getNumOfSeasons(),
           let genres = viewModel.getGenres(){
            if numOfSeasons == -1{
                self.episodesLabel.isHidden = true
                self.seasonsLabel.isHidden = true
                self.genreLabel.isHidden = true
            }
            else{
                DispatchQueue.main.async {
                    self.episodesLabel.text = "\(numOfEpisodes) Episodes"
                    self.seasonsLabel.text = "\(numOfSeasons) Seasons"
                    let genreNames = genres.compactMap { $0.name }
                    let joinedNames = genreNames.joined(separator: ", ")
                    print(joinedNames)
                    self.genreLabel.text = joinedNames
                    print(genres)
                }
            }
        
        }
    }
    
    func didFailToLoadDetails(error: Error) {
        print(error.localizedDescription)
    }
    
    
}
