//
//  DetailMovieView.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit

protocol DetailMovieViewDelegate: AnyObject {
    func favMovie()
}

class DetailMovieView: UIView {
    weak var delegate: DetailMovieViewDelegate?
    let tableView = UITableView()
    var movie: DetailMovie?
    
    init(movie: DetailMovie?) {
        self.movie = movie
        super.init(frame: .zero)
        setupView()
    }
    
    private func setupView() {
       // backgroundColor = UIColor.systemBackground
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
        tableView.register(HeaderDetailMovieTableViewCell.self, forCellReuseIdentifier: "cellHeader")
        tableView.register(InfoDetailMovieTableViewCell.self, forCellReuseIdentifier: "cellInfo")
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    public func updateMovie(_ movie: DetailMovie) {
        self.movie = movie
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}

extension DetailMovieView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader", for: indexPath) as? HeaderDetailMovieTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.movie = movie
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellInfo", for: indexPath) as? InfoDetailMovieTableViewCell else {
                return UITableViewCell()
            }
            cell.movie = movie
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0: return 200
            default: return UITableView.automaticDimension
        }
    }
    
}


extension DetailMovieView: HeaderDetailMovieCellDelegate {
    func tapFavorite() {
        delegate?.favMovie()
    }
}
