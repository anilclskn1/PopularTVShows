//
//  DetailsViewController.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 12.04.2023.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    
    
    var isFavorite: Bool = false
    var selectedID = -1
    var selectedTitle = ""
    var selectedImageURL = ""
    
    
    
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
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "genre label"
        label.textAlignment = .center
        return label
    }()
    
    let seasonsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "seasons label"
        label.textAlignment = .center
        return label
    }()
    
    let episodesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "episodes label"
        label.textAlignment = .center
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    // MARK: - UI Setup
    
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
            
            favoriteButton.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor, constant: 16),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 200),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

