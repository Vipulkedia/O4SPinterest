//
//  PinterestWallLayout.swift
//  O4SPinterest
//
//  Created by Vipul Kedia on 25/02/21.
//

import UIKit

protocol PinterestWallLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, aspectRatioOfImageFor indexPath: IndexPath) -> CGFloat
    func collectionView(_ collectionView: UICollectionView, heightOfLabelContentFor indexPath: IndexPath) -> CGFloat
}

class PinterestWallLayout: UICollectionViewFlowLayout {
    
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 2
    
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat = 0
    
    private var attributesCache: [UICollectionViewLayoutAttributes] = []
    
    weak var delegate: PinterestWallLayoutDelegate?

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
  
    override func prepare() {
        guard attributesCache.isEmpty, let collectionView = collectionView else {
            return
        }
        contentWidth = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        
        var xCoordinate: [CGFloat] = []
        for column in 0..<numberOfColumns {
          xCoordinate.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yCoordinate: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
          
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let aspectRatio = delegate?.collectionView(collectionView,aspectRatioOfImageFor: indexPath) ?? 1
            let pictureHeight = columnWidth * aspectRatio
            let labelHeight = delegate?.collectionView(collectionView, heightOfLabelContentFor: indexPath) ?? 0
            
            let totalHeight = (2 * cellPadding) + pictureHeight + labelHeight
            
            let frame = CGRect(x: xCoordinate[column],y: yCoordinate[column],width: columnWidth,height: totalHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            attributesCache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yCoordinate[column] = yCoordinate[column] + totalHeight
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
  
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesCache[indexPath.item]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesCache.filter { $0.frame.intersects(rect) }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }

    override func invalidateLayout() {
        super.invalidateLayout()
        contentHeight = 0
        contentWidth = 0
        attributesCache.removeAll()
    }
}

