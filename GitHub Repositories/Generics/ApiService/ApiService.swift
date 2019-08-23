//
//  ApiService.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import SwiftyJSON

fileprivate let baseUrl: String = "https://api.github.com"

enum Endpoint: String {
    case repositories = "/search/repositories"
}

protocol ServiceErrorProtocol {
    var message: String? { get }
}

class ApiService: ServiceProtocol {
    
    // MARK: Constants
    
    fileprivate lazy var defaultManager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [baseUrl: ServerTrustPolicy.pinCertificates(
            certificates: ServerTrustPolicy.certificates(in: Bundle.main),
            validateCertificateChain: true,
            validateHost: true
            ),
                                                                "insecure.expired-apis.com": .disableEvaluation
        ]
        
        var sessionManager = Alamofire.SessionManager()
        let configuration = URLSessionConfiguration.default
        
        sessionManager = Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        
        return sessionManager
    }()
    
    
    // MARK: Public
    
    // GET request
    func GET(endpoint: String, parameters: ApiService.Parameters? = nil, headers: HTTPHeaders? = nil) -> Observable<JSON> {
        return request(method: .get, endpoint: endpoint, parameters: parameters, headers: headers)
    }
    // POST request
    func POST(endpoint: String, parameters: ApiService.Parameters?, headers: HTTPHeaders?) -> Observable<JSON> {
        return request(method: .post, endpoint: endpoint, parameters: parameters, headers: headers)
    }
    // PUT request
    func PUT(endpoint: String, parameters: ApiService.Parameters?, headers: HTTPHeaders?) -> Observable<JSON> {
        return request(method: .put, endpoint: endpoint, parameters: parameters, headers: headers)
    }
    // DELETE request
    func DELETE(endpoint: String, parameters: ApiService.Parameters?, headers: HTTPHeaders?) -> Observable<JSON> {
        return request(method: .delete, endpoint: endpoint, parameters: parameters, headers: headers)
    }
    // Common request execution
    func request(method: HTTPMethod, endpoint: String, parameters: ApiService.Parameters?, headers: HTTPHeaders?) -> Observable<JSON>
    {
        let urlString = baseUrl + endpoint
        print("params: \(String(describing: parameters))")
        
        return Observable.create({ (observable) -> Disposable in
            
            let request = self.defaultManager.request(urlString, method: method, parameters: parameters ?? nil, encoding: URLEncoding.default, headers: headers).responseJSON { responseData in
                
                if let statusCode = responseData.response?.statusCode {
                    switch statusCode {
                    case 200, 201:
                        if let value = responseData.result.value {
                            let responseJson = JSON(value)
                            print("JSON: \(responseJson)")
                            
                            observable.onNext(responseJson)
                            observable.onCompleted()
                        }
                    default:
                        print("Error")
                    }
                    
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
            
        })
    }
}
