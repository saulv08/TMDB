//
//  DetailMovieViewController.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit
import CoreData

class DetailMovieViewController: UIViewController{
    private(set) var managedObjectContext: NSManagedObjectContext
    let movie: DetailMovie
    let viewModel = HomeMovieViewModel()
    let detailView: DetailMovieView
    
    init(movie: DetailMovie, context: NSManagedObjectContext) {
        self.movie = movie
        managedObjectContext =  context
        detailView = DetailMovieView(movie: viewModel.getDetailsMovie(movie, context: managedObjectContext))
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func showAlertFavorite(isFavorite: Bool) {
        let alertController = UIAlertController(title: nil,
                                                message: isFavorite ? "Se quitó de favoritos" : "Agregado a favoritos",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
        present(alertController, animated: true)
    }
    
    private func setupView() {
        title = "Acerca de este libro"
        hidesBottomBarWhenPushed = false
        detailView.delegate = self
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailMovieViewController: DetailMovieViewDelegate {
    func favMovie() {
        guard var detailMovie = viewModel.getDetailsMovie(movie, context: managedObjectContext) else {
            return
        }
        detailMovie.isFavorite(!detailMovie.isFavorite)
        detailView.updateMovie(detailMovie)
        showAlertFavorite(isFavorite: viewModel.isMovieFav(movie, context: managedObjectContext))
    }
}
