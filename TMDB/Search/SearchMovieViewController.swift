//
//  SearchMovieViewController.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit
import CoreData

class SearchMovieViewController: UIViewController{
    private(set) var managedObjectContext: NSManagedObjectContext
    let activityIndicator = UIActivityIndicatorView()
    let searchController = UISearchController(searchResultsController: nil)
    let listMoviesView = ListMoviesView()
    let emptySearchView = EmptyMovieSearchView()
    let viewModel = SearchMovieViewModel()
    var isSearchBarEmpty: Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var filteredMovies = [Movie]()
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSearchController()
    }
    
    private func setup() {
        //remove hard text
        title = "Buscar"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(listMoviesView)
        listMoviesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listMoviesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listMoviesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listMoviesView.topAnchor.constraint(equalTo: view.topAnchor),
            listMoviesView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        listMoviesView.delegate = self
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        activityIndicator.hidesWhenStopped = true
        view.addSubview(emptySearchView)
        emptySearchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptySearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptySearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptySearchView.topAnchor.constraint(equalTo: view.topAnchor),
            emptySearchView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func showEmptyView(withSearch search: String) {
        emptySearchView.updateTitle(withSearch: search)
        emptySearchView.isHidden = false
    }
    
    func hideEmptyView() {
        emptySearchView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchMovieViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let search = searchBar.text else {
            return
        }
        saveSearch(search)
        activityIndicator.startAnimating()
        viewModel.searchMovies(search) { movies in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if movies.isEmpty && !search.isEmpty {
                    self.showEmptyView(withSearch: search)
                } else {
                    self.hideEmptyView()
                }
                self.listMoviesView.fill(movies)
            }
        }
    }
    
    private func saveSearch(_ search: String) {
        var searchs = [String]()
        if let lastSearchs = UserDefaults.standard.object(forKey: "searchs") as? [String] {
            searchs = lastSearchs
        }
        searchs.append(search)
        UserDefaults.standard.set(searchs, forKey: "searchs")
    }
}

extension SearchMovieViewController: ListMoviesViewDelegate {
    func didSelectMovie(_ movie: DetailMovie) {
        listMoviesView.endEditing(true)
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(DetailMovieViewController(movie: movie,
                                                                          context: managedObjectContext),
                                                                        animated: true)
        hidesBottomBarWhenPushed = false
    }
}
