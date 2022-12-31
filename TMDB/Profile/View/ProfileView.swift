//
//  ProfileView.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import Foundation
import UIKit

protocol ProfileViewDelegate: AnyObject {
    func tapFavMovie(_ movie: DetailMovie)
}

class ProfileView: UIView {
    weak var delegate: ProfileViewDelegate?
    let imageUserView = UIImageView()
    let nameLabel = UILabel()
    let favLabel = UILabel()
    let listMoviesView = ListMoviesView()
    
    init(){
        super.init(frame: .zero)
        setupView()
    }
    
    public func setInfo(name: String, image: UIImage) {
        nameLabel.text = name
        imageUserView.image = image
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        addSubview(imageUserView)
        imageUserView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageUserView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageUserView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            imageUserView.heightAnchor.constraint(equalToConstant: 120),
            imageUserView.widthAnchor.constraint(equalToConstant: 120),
        ])
        imageUserView.clipsToBounds = true
        imageUserView.layer.masksToBounds = true
        imageUserView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        imageUserView.layer.borderWidth = 4
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: imageUserView.bottomAnchor, constant: 10)
        ])
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        addSubview(favLabel)
        favLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            favLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
        ])
        favLabel.text = "Favoritos" + " ⭐️"
        favLabel.textColor = .black
        favLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        addSubview(listMoviesView)
        listMoviesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listMoviesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listMoviesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listMoviesView.topAnchor.constraint(equalTo: favLabel.bottomAnchor,constant: 20),
            listMoviesView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        listMoviesView.delegate = self
        listMoviesView.tableView.backgroundColor = colorAlternativo
    }

    public func fillFavoritesMovies(_ movies: [DetailMovie]) {
        listMoviesView.fill(movies)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageUserView.layer.cornerRadius = imageUserView.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView: ListMoviesViewDelegate {
    func didSelectMovie(_ movie: DetailMovie) {
        delegate?.tapFavMovie(movie)
    }
}

