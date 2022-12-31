//
//  SearchMovieViewModel.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import Foundation

class SearchMovieViewModel {
    private let api = API()
    
    public func searchMovies(_ search: String, completion: @escaping ([DetailMovie]) -> ()) {
        api.fetchWithSearch(search) { movies in
            completion(movies.map({
                self.getDetailMovie($0)
            }))
        }
    }
    private func getDetailMovie(_ movie: Movie) -> DetailMovie {
        return DetailMovie(id: movie.id,
                           original_language: movie.original_language,
                           original_title: movie.original_title,
                           overview: movie.overview,
                           poster_path: movie.poster_path,
                           release_date: movie.release_date,
                           rating: movie.vote_average,
                           isFavorite: false)
    }
}
