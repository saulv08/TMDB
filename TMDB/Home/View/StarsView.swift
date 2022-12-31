//
//  StarsView.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit

class StartsView: UIView {
    let start1View = UIImageView()
    let start2View = UIImageView()
    let start3View = UIImageView()
    let start4View = UIImageView()
    let start5View = UIImageView()
    
    
    var rating: Int? {didSet{
        guard let rating = rating else {
            return
        }
        switch rating {
        case 0:
            start1View.image = UIImage(systemName: "star")
            start2View.image = UIImage(systemName: "star")
            start3View.image = UIImage(systemName: "star")
            start4View.image = UIImage(systemName: "star")
            start5View.image = UIImage(systemName: "star")
        case 1:
            start1View.image = UIImage(systemName: "star.fill")
            start2View.image = UIImage(systemName: "star")
            start3View.image = UIImage(systemName: "star")
            start4View.image = UIImage(systemName: "star")
            start5View.image = UIImage(systemName: "star")
        case 2:
            start1View.image = UIImage(systemName: "star.fill")
            start2View.image = UIImage(systemName: "star.fill")
            start3View.image = UIImage(systemName: "star")
            start4View.image = UIImage(systemName: "star")
            start5View.image = UIImage(systemName: "star")
        case 3:
            start1View.image = UIImage(systemName: "star.fill")
            start2View.image = UIImage(systemName: "star.fill")
            start3View.image = UIImage(systemName: "star.fill")
            start4View.image = UIImage(systemName: "star")
            start5View.image = UIImage(systemName: "star")
        case 4:
            start1View.image = UIImage(systemName: "star.fill")
            start2View.image = UIImage(systemName: "star.fill")
            start3View.image = UIImage(systemName: "star.fill")
            start4View.image = UIImage(systemName: "star.fill")
            start5View.image = UIImage(systemName: "star")
        case 5:
            start1View.image = UIImage(systemName: "star.fill")
            start2View.image = UIImage(systemName: "star.fill")
            start3View.image = UIImage(systemName: "star.fill")
            start4View.image = UIImage(systemName: "star.fill")
            start5View.image = UIImage(systemName: "star.fill")
        default: return
        }
        
    }}
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(start1View)
        start1View.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            start1View.leadingAnchor.constraint(equalTo: leadingAnchor),
            start1View.heightAnchor.constraint(equalToConstant: 22),
            start1View.widthAnchor.constraint(equalToConstant: 22),
            start1View.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        start1View.contentMode = .scaleAspectFit
        
        addSubview(start2View)
        start2View.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            start2View.leadingAnchor.constraint(equalTo: start1View.trailingAnchor,
                                                constant: 5),
            start2View.heightAnchor.constraint(equalToConstant: 22),
            start2View.widthAnchor.constraint(equalToConstant: 22),
            start2View.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        start2View.contentMode = .scaleAspectFit
        
        addSubview(start3View)
        start3View.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            start3View.leadingAnchor.constraint(equalTo: start2View.trailingAnchor,
                                                constant: 5),
            start3View.heightAnchor.constraint(equalToConstant: 22),
            start3View.widthAnchor.constraint(equalToConstant: 22),
            start3View.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        start3View.contentMode = .scaleAspectFit
        
        addSubview(start4View)
        start4View.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            start4View.leadingAnchor.constraint(equalTo: start3View.trailingAnchor,
                                                constant: 5),
            start4View.heightAnchor.constraint(equalToConstant: 22),
            start4View.widthAnchor.constraint(equalToConstant: 22),
            start4View.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        start4View.contentMode = .scaleAspectFit
        
        addSubview(start5View)
        start5View.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            start5View.leadingAnchor.constraint(equalTo: start4View.trailingAnchor,
                                                constant: 5),
            start5View.heightAnchor.constraint(equalToConstant: 22),
            start5View.widthAnchor.constraint(equalToConstant: 22),
            start5View.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        start5View.contentMode = .scaleAspectFit
        
        
    }
}
