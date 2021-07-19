//
//  GradientView.swift
//  Test
//
//  Created by Eugen on 17.07.2021.
//

import UIKit

class GradientView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }
}
