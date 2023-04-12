//
//  TVShowForTableView.swift
//  PopularTVShows
//
//  Created by Anıl Çalışkan on 12.04.2023.
//

import Foundation
import UIKit

class TVShowForTableView {
    var title: String
    var rating: Double
    var isFavorite: Bool
    var image: String
    
    init(title: String, rating: Double, isFavorite: Bool, image: String) {
        self.title = title
        self.rating = rating
        self.isFavorite = isFavorite
        self.image = image
    }
}
