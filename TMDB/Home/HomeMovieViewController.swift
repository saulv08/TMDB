//
//  HomeMovieViewController.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit
import CoreData

class HomeMovieViewController: UIViewController {

    private(set) var managedObjectContext: NSManagedObjectContext
    let activityIndicator = UIActivityIndicatorView()
    let viewModel = HomeMovieViewModel()
    let listMoviesView = ListMoviesView()
    let colorAlternativo = UIColor(red: 172/255, green: 158/255, blue: 131/255, alpha: 1.00)
    
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getTopMovies()
    }
    
    private func setup() {
        view.backgroundColor = UIColor.systemBackground
        title = "Inicio"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(listMoviesView)
        listMoviesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listMoviesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listMoviesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listMoviesView.topAnchor.constraint(equalTo: view.topAnchor),
            listMoviesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        listMoviesView.delegate = self
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        activityIndicator.hidesWhenStopped = true
    }
    
    private func getTopMovies() {
        activityIndicator.startAnimating()
        viewModel.getPopularMovies { movies in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.listMoviesView.fill(movies)
            }
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HomeMovieViewController: ListMoviesViewDelegate {
    func didSelectMovie(_ movie: DetailMovie) {
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(DetailMovieViewController(movie: movie, context: managedObjectContext), animated: true)
        hidesBottomBarWhenPushed = false
        
    }
}
