//
//  ImageCache.swift
//  O4SPinterest
//
//  Created by Vipul Kedia on 25/02/21.
//

import Foundation

import UIKit

class ImageCache {
    static let shared = ImageCache()
    let images = NSCache<NSString, UIImage>()

    init() {
        images.countLimit = Count.imageCacheStorage
    }
    
}

// MARK: - Custom Accessors
extension ImageCache {
    func set(_ image: UIImage, forKey key: String) {
        images.setObject(image, forKey: key as NSString)
    }

    func image(forKey key: String) -> UIImage? {
        return images.object(forKey: key as NSString)
    }
}

