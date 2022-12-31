//
//  SplashView.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import Foundation
import UIKit

class SplashView: UIView {
    private var path: UIBezierPath!
    let colorBlue = UIColor(red: 89/255, green: 144/255, blue: 255/255, alpha: 1.00)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/3, y: self.frame.size.height/3),
                            radius: self.frame.size.height/3,
                            startAngle: deg2rad(CGFloat(180)),
                            endAngle: deg2rad(CGFloat(0)),
                            clockwise: true)
        
        colorBlue.setFill()
        path.fill()

        UIColor.blue.setStroke()
        path.stroke()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
    
    public func animateView(completion: @escaping() -> Void) {
        UIView.animate(withDuration: 2, delay: 0.5, options: [.curveEaseInOut]) {
            self.transform = CGAffineTransform(rotationAngle: self.deg2rad(180)).scaledBy(x: 2, y: 2)
            self.alpha = 0
        } completion: { _ in
            completion()
        }
    }
    
}
