//
//  PictureCell.swift
//  O4SPinterest
//
//  Created by Vipul Kedia on 24/02/21.
//

import UIKit

class PictureCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    
    override var isHighlighted: Bool {
      didSet {
        animateTransform()
      }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 4.0
    }
    
    static func textHeight(text: String, width: CGFloat) -> CGFloat {
        let font = UIFont(name: "Gilroy-SemiBold", size: 15) ?? UIFont.systemFont(ofSize: 15)
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let constrainedSize = CGSize(width: width - insets.left - insets.right, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [ NSAttributedString.Key.font: font ]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.height) + insets.top + insets.bottom;
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

}
