//
//  HeaderDetailMovieTableViewCell.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit

protocol HeaderDetailMovieCellDelegate: AnyObject {
    func tapFavorite()
}

class HeaderDetailMovieTableViewCell: UITableViewCell {
    weak var delegate: HeaderDetailMovieCellDelegate?
    let titleLabel = UILabel()
    let posterImageView = UIImageView()
    let favButton = UIButton()
    
    var movie: DetailMovie? { didSet{
        guard let movie = movie else {
            return
        }
        posterImageView.downloaded(from: movie.poster_path)
        titleLabel.text = movie.original_title
        if movie.isFavorite {
            //remove hard text
            favButton.setTitle("Quitar de Favoritos ➖", for: .normal)
        } else {
            favButton.setTitle("Agregar a favoritos ⭐️", for: .normal)
        }
    }}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .none
        contentView.addSubview(contentView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: 20),
            posterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 250),
            posterImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,
                                               constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                           constant: 20)
        ])
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        contentView.addSubview(favButton)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favButton.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,
                                               constant: 10),
            favButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -20),
            favButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        favButton.setTitleColor(UIColor.blue, for: .normal)
        favButton.addTarget(self,
                            action: #selector(tapFav),
                            for: .touchUpInside)
    }
    
    @objc func tapFav() {
        delegate?.tapFavorite()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

