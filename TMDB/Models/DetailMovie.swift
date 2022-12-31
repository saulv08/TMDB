//
//  DetailMovie.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import Foundation

struct DetailMovie{
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let poster_path: String
    let release_date: String
    let rating: Double
    var isFavorite: Bool
     
    mutating func isFavorite(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}
