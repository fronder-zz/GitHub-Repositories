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
    
    associatedtype ResponseData = Observable<JSON>
    typealias Parameters = [String : Any]
    
    // GET
    func GET(endpoint: String, parameters: Parameters?, headers: HTTPHeaders?) -> ResponseData
    // POST
    func POST(endpoint: String, parameters: Parameters?, headers: HTTPHeaders?) -> ResponseData
    // PUT
    func PUT(endpoint: String, parameters: Parameters?, headers: HTTPHeaders?) -> ResponseData
    // DELETE
    func DELETE(endpoint: String, parameters: Parameters?, headers: HTTPHeaders?) -> ResponseData
    func request(method: HTTPMethod, endpoint: String, parameters: Parameters?, headers: HTTPHeaders?) -> ResponseData
}
