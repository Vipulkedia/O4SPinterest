//
//  PictureController.swift
//  O4SPinterest
//
//  Created by Vipul Kedia on 24/02/21.
//

import Alamofire
import Kingfisher

struct PictureController {
    
    typealias FetchImageResult = Result<UIImage, KingfisherError>
    typealias FetchImageCompletion = (FetchImageResult) -> Void
    
    static func getListOfPictures(completion:@escaping (Result<[Picture], AFError>)->Void) {
        PictureGateway.getListOfPictures { completion($0)}
    }
    
    static func loadImage (for picture: Picture, completion: @escaping FetchImageCompletion) {
        if let image = ImageCache.shared.image(forKey: picture.id) {
            completion(Result.success(image))}
        else {
            guard let urlString = picture.images?.regular, let url = URL(string: urlString) else {return}
            DispatchQueue.global().async {
                KingfisherManager.shared.retrieveImage(with: url) { (result) in
                    switch result {
                    case .success(let result):
                        ImageCache.shared.set(result.image, forKey: picture.id)
                        completion(.success(result.image))
                    case .failure(let error):
                        print(error)
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
}
