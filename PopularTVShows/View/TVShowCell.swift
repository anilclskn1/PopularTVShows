//
//  TVShowCell.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 12.04.2023.
//

import Foundation
import UIKit

class TVShowCell: UITableViewCell {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    var favoriteIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "favorite_icon"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var showImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(showImageView)
        addSubview(titleLabel)
        addSubview(ratingLabel)
        addSubview(favoriteIcon)
        
        showImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            showImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            showImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            showImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            showImageView.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.leadingAnchor.constraint(equalTo: showImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteIcon.leadingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            ratingLabel.leadingAnchor.constraint(equalTo: showImageView.trailingAnchor, constant: 16),
            ratingLabel.trailingAnchor.constraint(equalTo: favoriteIcon.leadingAnchor, constant: -16),
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            
            favoriteIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            favoriteIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 24),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with show: TVShowForTableView) {
        showImageView.image = .actions
        titleLabel.text = show.title
        ratingLabel.text = "Rating: \(show.rating)/10"
        favoriteIcon.isHidden = !show.isFavorite
    }
}
