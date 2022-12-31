//
//  ProfileViewModel.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit
import CoreData

class ProfileViewModel {
    
    public func getInfoUser(fromContext context: NSManagedObjectContext) -> (name: String, image: UIImage)? {
        guard let username = UserDefaults.standard.object(forKey: "username") as? String,
              let password = UserDefaults.standard.object(forKey: "password") as? String else {
            return nil
        }
        guard let userModel = UserModel.fetch(name: username, pwd: password, from: context),
              let imageUser = loadImageFromDiskWith(fileName: userModel.imageURL) else {
                  return nil
              }
        return (userModel.username, imageUser)
    }
    
    public func getFavoritesMovies(fromContext context: NSManagedObjectContext) -> [DetailMovie] {
        guard let user = UserDefaults.standard.object(forKey: "username") as? String else {
            return [DetailMovie]()
        }
        return MovieFavoriteModel.fetch(fromUser: user, from: context).map {
            infoMovie($0)
        }
    }
    
    private func infoMovie(_ movie: MovieFavoriteModel) -> DetailMovie {
        return DetailMovie(id: Int(movie.id),
                           original_language: movie.original_language,
                           original_title: movie.original_title,
                           overview: movie.overview,
                           poster_path: movie.poster_path,
                           release_date: movie.poster_path,
                           rating: movie.rating,
                           isFavorite: true)
    }
    
    private func loadImageFromDiskWith(fileName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
}
