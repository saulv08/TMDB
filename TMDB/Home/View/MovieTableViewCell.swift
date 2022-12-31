//
//  MovieTableViewCell.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let languageLabel = UILabel()
    let posterImageView = UIImageView()
    let overviewLabel = UILabel()
    let releaseDateLabel = UILabel()
    let backgroundCoverImageView = UIView()
    let startsView = StartsView()
    
    var movie: DetailMovie? { didSet{
        guard let movie = movie else{
            return
        }
        titleLabel.text = movie.original_title
        languageLabel.text = movie.original_language
        posterImageView.downloaded(from: movie.poster_path)
        overviewLabel.text = movie.overview
        releaseDateLabel.text = movie.release_date
        startsView.rating = Int(movie.rating) //rating in Double vs rating in INT
        
    }}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.systemBackground
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(backgroundCoverImageView)
        backgroundCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: 10),
            backgroundCoverImageView.heightAnchor.constraint(equalToConstant: 120),
            backgroundCoverImageView.widthAnchor.constraint(equalToConstant: 150),
            backgroundCoverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        backgroundCoverImageView.backgroundColor = UIColor.random()
        backgroundCoverImageView.clipsToBounds = true
        backgroundCoverImageView.layer.masksToBounds = true
        backgroundCoverImageView.layer.cornerRadius = 4
        backgroundCoverImageView.dropShadow()
        
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.centerXAnchor.constraint(equalTo: backgroundCoverImageView.centerXAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 180),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.bottomAnchor.constraint(equalTo: backgroundCoverImageView.bottomAnchor)
        ])
        posterImageView.dropShadow()
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundCoverImageView.trailingAnchor,
                                                constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -20)
        ])
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        contentView.addSubview(languageLabel)
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                constant: 20),
            languageLabel.leadingAnchor.constraint(equalTo: backgroundCoverImageView.trailingAnchor,
                                                constant: 20),
            languageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -20)
        ])
        languageLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

