//
//  MovieFavoriteModel.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import CoreData

final class MovieFavoriteModel: NSManagedObject, Managed {
    @NSManaged fileprivate(set) var id: Int16
    @NSManaged var user: String
    @NSManaged var original_language: String
    @NSManaged var original_title: String
    @NSManaged var overview: String
    @NSManaged var poster_path: String
    @NSManaged var release_date: String
    @NSManaged var rating: Double
    
    static func insert(into context: NSManagedObjectContext,
                       fromUser: String,
                       movie: DetailMovie) {
        let movieModel: MovieFavoriteModel = context.insertObject()

        movieModel.id = Int16(movie.id)
        movieModel.original_title = movie.original_title
        movieModel.original_language = movie.original_language
        movieModel.overview = movie.overview
        movieModel.poster_path = movie.poster_path
        movieModel.release_date = movie.release_date
        movieModel.rating =  movie.rating
    }
    
    static func fetch(fromUser: String, from context: NSManagedObjectContext) -> [MovieFavoriteModel] {
        
        let predicate = NSPredicate(format: "%K == %@",
                                    #keyPath (user),
                                    fromUser)
        let request = MovieFavoriteModel.sortedFetchRequest
        request.predicate = predicate
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            return [MovieFavoriteModel]()
        }
    }
    
    static func isMovieFav(idMovie: Int,
                           fromUser: String,
                           from context: NSManagedObjectContext) -> Bool {
        let predicate = NSPredicate(format: "%K == %d AND %K == %@",
                                    #keyPath(id),
                                    idMovie,
                                    #keyPath(user),
                                    fromUser)
        let request = MovieFavoriteModel.sortedFetchRequest
        request.predicate = predicate
        do {
            if let _ =  try context.fetch(request).first {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    static func removeMovie(idMovie: Int,
                            fromUser: String,
                            from context: NSManagedObjectContext){
        let predicate = NSPredicate(format: "%K == %d",
                                    #keyPath(id),
                                    idMovie,
                                    #keyPath(user),
                                    fromUser)
        let request = MovieFavoriteModel.sortedFetchRequest
        request.predicate = predicate
        do {
            if let movie = try context.fetch(request).first {
                context.delete(movie)
            }
        } catch {
            return
        }
    }
    
}
