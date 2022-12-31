//
//  HomeMoviesViewModel.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import Foundation
import CoreData

class HomeMovieViewModel {
    public let api = API()
    
    public func getPopularMovies(completion: @escaping ([DetailMovie]) -> ()) {
        api.fetchTop { movies in
            completion(movies.compactMap({
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
    
    public func getDetailsMovie(_ movie: DetailMovie,
                                context: NSManagedObjectContext) -> DetailMovie? {
        guard let user = UserDefaults.standard.object(forKey: "username") as?
                String else {
                    return nil
                }
        return DetailMovie(id: movie.id,
                           original_language: movie.original_language,
                           original_title: movie.original_title,
                           overview: movie.overview,
                           poster_path: movie.poster_path,
                           release_date: movie.release_date,
                           rating: movie.rating,
                           isFavorite: MovieFavoriteModel.isMovieFav(idMovie: movie.id,
                                                                    fromUser: user,
                                                                    from: context))
    }
    
    public func isMovieFav(_ movie: DetailMovie, context: NSManagedObjectContext) -> Bool {
        guard let user = UserDefaults.standard.object(forKey: "username") as?
                String else {
                    return false
                }
        if MovieFavoriteModel.isMovieFav(idMovie: movie.id,
                                         fromUser: user,
                                         from: context){
            context.performChanges {
                MovieFavoriteModel.removeMovie(idMovie: movie.id,
                                               fromUser: user,
                                               from: context)
            }
            return true
        } else {
            context.performChanges {
                MovieFavoriteModel.insert(into: context,
                                          fromUser: user, movie: movie)
            }
            return false
        }
    }
    
}
