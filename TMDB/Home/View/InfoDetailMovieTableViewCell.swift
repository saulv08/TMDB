//
//  InfoDetailMovieTableViewCell.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit

class InfoDetailMovieTableViewCell: UITableViewCell {
    let overviewLabel = UILabel()
    
    var movie: DetailMovie? { didSet{
        guard let movie = movie else {
            return
        }
        overviewLabel.text = movie.overview
    }}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .blue
        contentView.addSubview(overviewLabel)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            overviewLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
        ])
        overviewLabel.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}
