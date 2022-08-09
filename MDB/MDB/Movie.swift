//
//  Movie.swift
//  MDB
//
//  Created by Mariano Manuel on 8/4/22.
//

import Foundation

struct Movie {

    var movieTitle: String
    var posterImage: Data
    var releaseDate: String
    var rating: String
    var details: String
    
    init(movieTitle: String, posterImage: Data, releaseDate: String, rating: String, details: String) {
        self.movieTitle = movieTitle
        self.posterImage = posterImage
        self.releaseDate = releaseDate
        self.rating = rating
        self.details = details
    }
    
}
