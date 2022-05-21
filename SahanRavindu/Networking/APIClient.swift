//
//  APIClient.swift
//  SahanRavindu
//
//  Created by Sahan Ravindu on 11/2/20.
//

import Alamofire

struct MultipartData {
    var imgData:Data
    var name:String // photo
    var fileName:String // photo.jpg
    var mimeType:String // image/jpg
}

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        NetworkActivityIndicatorManager.networkOperationStarted()
        return AF.request(route).responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in
            NetworkActivityIndicatorManager.networkOperationFinished()
            completion(response.result)
        }
    }
    
    @discardableResult
    private static func performUpload<T:Decodable>(route: APIRouter, multipartData: MultipartData?, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (AFResult<T>)->Void) -> DataRequest {
        NetworkActivityIndicatorManager.networkOperationStarted()
        return AF.upload(multipartFormData: { multipartFormData in
            
            if let multipartData = multipartData {
                multipartFormData.append(multipartData.imgData, withName: multipartData.name, fileName: multipartData.fileName, mimeType: multipartData.mimeType)
            }
            
            if let param = route.parameters {
                for (key, value) in param {
                    multipartFormData.append(("\(value)" as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
            
        }, with: route).responseDecodable(decoder: decoder) { (response: AFDataResponse<T>) in
            NetworkActivityIndicatorManager.networkOperationFinished()
            completion(response.result)
        }
    }
    
    // Cancel Event
    static func register(parameters: RegisterRequestModel, completion:@escaping (Result<SuccessModel, AFError>)->Void) {
        performUpload(route: APIRouter.register(username: parameters.username, password: parameters.password, email: parameters.email, gender: parameters.gender), multipartData: parameters.imgData, completion: completion)
    }
    
    static func getMovies(page: Int, completion:@escaping (Result<Welcome, AFError>)->Void) {
        performRequest(route: APIRouter.popular(page: page), completion: completion)
    }
    
}
