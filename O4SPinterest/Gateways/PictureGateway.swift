//
//  PictureGateway.swift
//  O4SPinterest
//
//  Created by Vipul Kedia on 24/02/21.
//

import Foundation
import Alamofire

class PictureGateway {
    
    /**
     - Parameter route: URLRequestConvertible type object
     - Parameter decoder: JSON decoder for decoding strategies and configurations
     */
    @discardableResult
    private static func performRequest<T:Decodable>(route:PictureRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
                        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                            completion(response.result)
        }
    }
    
    /**
     This method uses the list of pictures endpoint to fetch list of images
     - Returns: List of Picture
     */
    static func getListOfPictures(completion:@escaping (Result<[Picture], AFError>)->Void) {
        performRequest(route: PictureRouter.listOfPictures, completion: completion)
    }
}
