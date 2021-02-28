//
//  ViewController.swift
//  O4SPinterest
//
//  Created by Vipul Kedia on 24/02/21.
//

import UIKit

class PinterestWallVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var refreshControl: UIRefreshControl?
    
    var pictures: Array<Picture> = []

    let pictureCellID = "PictureCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getListOfPictures()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if let layout = collectionView?.collectionViewLayout as? PinterestWallLayout {
          layout.invalidateLayout()
        }
    }
    
    func getListOfPictures() {
        PictureController.getListOfPictures { [unowned self] result in
            switch result {
            case .success(let pictures):
                refreshControl?.endRefreshing()
                self.pictures = pictures
                self.collectionView.reloadData()
            case .failure(let error):
                refreshControl?.endRefreshing()
                print("Error:", error)
            }
        }
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = Color.appColor
        refreshControl?.addTarget(self, action: #selector(onPullToRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.addSubview(refreshControl!)
    }
    
    @objc func onPullToRefresh() {
        getListOfPictures()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = PinterestWallLayout()
        if let layout = collectionView?.collectionViewLayout as? PinterestWallLayout {
          layout.delegate = self
        }
        collectionView.register(UINib(nibName: pictureCellID, bundle: nil), forCellWithReuseIdentifier: pictureCellID)
        collectionView?.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        setupRefreshControl()
    }

}

// MARK: - UICollectionViewDelegate

extension PinterestWallVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let index = indexPath.row
        let picture = pictures[index]
        
        let identifier = "\(index)" as NSString
        
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { [unowned self] _ in
            let detailAction = UIAction(title: "See Details", handler: {_ in
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                if let detailVC = storyboard.instantiateViewController(withIdentifier: "PictureDetailVC") as? PictureDetailVC {
                    detailVC.picture = picture
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }
            })
            
            return UIMenu(title: "Options", image: nil, children: [detailAction])
        }
    }
}

// MARK: - UICollectionViewDataSource

extension PinterestWallVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {pictures.count}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: pictureCellID, for: indexPath as IndexPath) as? PictureCell {
            let picture = pictures[indexPath.row]
            PictureController.loadImage(for: picture) { (result) in
                if case .success(let image) = result {
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                }
            }
            cell.numberOfLikesLabel.text = "\(picture.likes ?? 0)"
            cell.usernameLabel.text = "\(picture.user?.username ?? picture.user?.name ?? "")"
            return cell
        }
        return UICollectionViewCell()
    }
    
}

//MARK: - PinterestWallLayoutDelegate
extension PinterestWallVC: PinterestWallLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, aspectRatioOfImageFor indexPath: IndexPath) -> CGFloat {
        let picture = pictures[indexPath.row]
        return CGFloat(picture.aspectRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, heightOfLabelContentFor indexPath: IndexPath) -> CGFloat {
        let width = collectionView.frame.width / 2
        let picture = pictures[indexPath.row]
        if let username = picture.user?.username {
            return PictureCell.textHeight(text: username, width: width)
        }
        return 0
    }
    
}
