//
//  Service.swift
//  GitHub Repositories
//
//  Created by Hasan on 7/25/19.
//  Copyright © 2019 Hasan. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

protocol ServiceProtocol {
    
    associatedtype ServiceResponseResult = Observable<JSON>
    typealias Parameters = [String : Any]
    
    // GET
    func GET(endpoint: String, parameters: Parameters?, headers: HTTPHeaders?) -> ServiceResponseResult
    // POST
    func POST(endpoint: String, parameters: Parameters?, headers: HTTPHeaders?) -> ServiceResponseResult
    // PUT
    func PUT(endpoint: String, parameters: Parameters?, headers: HTTPHeaders?) -> ServiceResponseResult
    // DELETE
    func DELETE(endpoint: String, parameters: Parameters?, headers: HTTPHeaders?) -> ServiceResponseResult
    
    // Common
    func request(method: HTTPMethod, endpoint: String, parameters: Parameters?, headers: HTTPHeaders?) -> ServiceResponseResult
}
