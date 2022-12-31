//
//  API.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import Foundation

class API {

    func fetchTop(completion: @escaping([Movie]) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=6385947ffd06d95a96c47854d8df8917")!
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return completion([Movie]())
            }
            do {
                let movies = try JSONDecoder().decode(Movies.self, from: data)
                return completion(movies.results)
            } catch let error{
                print(error)
                completion([Movie]())
            }
        }
        task.resume()
    }
    
    func fetchWithSearch(_ search: String, completion: @escaping([Movie]) -> Void) {
        let search = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=6385947ffd06d95a96c47854d8df8917&query=\(search)")!
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return completion([Movie]())
            }
            do {
                let movies = try JSONDecoder().decode(Movies.self, from: data)
                return completion(movies.results)
            } catch {
                completion([Movie]())
            }
        }
        task.resume()
    }
        
}
