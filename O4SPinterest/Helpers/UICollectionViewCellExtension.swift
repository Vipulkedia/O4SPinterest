//
//  UICollectionViewCellExtension.swift
//  O4SPinterest
//
//  Created by Vipul Kedia on 25/02/21.
//

import UIKit

extension UICollectionViewCell {
    
    func animateTransform() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction], animations: { [unowned self] in
            self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            self.alpha = self.isHighlighted ? 0.85 : 1.0
        })
    }
    
}
