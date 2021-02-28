//
//  ImageViewExtension.swift
//  O4SPinterest
//
//  Created by Vipul Kedia on 25/02/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: String?, placeholder: UIImage? = nil) {
         
         guard let urlString = url else {
             self.image = placeholder
             return
         }
         
         guard let url = URL(string: urlString) else {
             self.image = placeholder
             return
         }
         
        self.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(1)),])
     }
}

