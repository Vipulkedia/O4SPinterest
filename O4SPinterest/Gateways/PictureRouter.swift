//
//  PictureEndpoint.swift
//  O4SPinterest
//
//  Created by Vipul Kedia on 24/02/21.
//

import Alamofire

/**
 Handles all the requests for pictures
 */
enum PictureRouter: APIConfiguration {
    
    case listOfPictures
 
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .listOfPictures:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .listOfPictures:
            return "/raw/wgkJgazE"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .listOfPictures:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try AppURLS.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
 
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
