//
//  EmptyMovieSearchView.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit

class EmptyMovieSearchView: UIView{
    let titleLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    func updateTitle(withSearch search: String) {
        titleLabel.text = "No result for: " + search
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

