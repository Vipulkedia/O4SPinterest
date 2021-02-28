//
//  PictureDetailVC.swift
//  O4SPinterest
//
//  Created by Vipul Kedia on 27/02/21.
//

import UIKit

class PictureDetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    var picture: Picture?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        if let picture = picture {
            imageHeight.constant = CGFloat(picture.aspectRatio) * view.bounds.width
            setImage(picture)
            nameLabel.text = "By \(picture.user?.name ?? "")"
            likesLabel.text = "\(picture.likes ?? 0)"
        }
    }
    
    private func setImage(_ picture: Picture) {
        PictureController.loadImage(for: picture) { (result) in
            if case .success(let image) = result {
                DispatchQueue.main.async { [unowned self] in
                    self.imageView.image = image
                }
            }
        }
    }

}

//MARK: - Scroll View Delegate

extension PictureDetailVC : UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        contentView
    }
    
}
