//
//  UIImageViewExtension.swift
//  Test
//
//  Created by Eugen on 19.07.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromURL(url: String){
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}

