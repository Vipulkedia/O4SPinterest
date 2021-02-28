//
//  Picture.swift
//  O4SPinterest
//
//  Created by Vipul Kedia on 24/02/21.
//

import Foundation

struct Picture: Codable {
    let id: String
    let createdAt: String?
    let width: Int?
    let height: Int?
    let color: String?
    let likes: Int?
    let user: User?
    let images: ImageUrls?
    
    private enum CodingKeys : String, CodingKey {
        case id, width, height, color, likes, user, createdAt = "created_at", images="urls"
    }
        
}

extension Picture {
    
    var aspectRatio : Float {
        guard let width = (width) , let height = height else {return 0}
        return Float(height) / Float(width)
    }
    
}
