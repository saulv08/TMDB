//
//  UIImageView.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import UIKit

//MARK: - Function to download an image

extension UIImageView {
    func downloaded(from url: URL?, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = url else {
            return
        }
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: "http://image.tmdb.org/t/p/w500" + link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
