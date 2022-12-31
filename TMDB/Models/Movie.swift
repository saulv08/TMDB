//
//  Movie.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let poster_path: String
    let release_date: String
    let vote_average: Double
}

struct Movies: Codable{
    let results: [Movie]
}
