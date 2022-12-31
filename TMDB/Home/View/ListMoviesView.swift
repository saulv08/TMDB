//
//  ListMoviesView.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit

protocol ListMoviesViewDelegate: AnyObject {
    func didSelectMovie(_ movie: DetailMovie)
}

class ListMoviesView: UIView {
    weak var delegate: ListMoviesViewDelegate?
    let tableView = UITableView()
    var movies = [DetailMovie]()
    let colorAlternativo = UIColor(red: 172/255, green: 158/255, blue: 131/255, alpha: 1.00)
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    public func fill(_ movies: [DetailMovie]){
        self.movies = movies
        tableView.reloadData()
    }
    
    private func setupView() {
       //tableView.backgroundColor = colorAlternativo
        tableView.separatorStyle = .none
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListMoviesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.movie = movies[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectMovie(movies[indexPath.item])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
