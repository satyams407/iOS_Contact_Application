//
//  NetworkRequest.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 23/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

class NetworkRequest {
    static let sharedInstance = NetworkRequest()
    private init() {}
    
    @discardableResult func executeRequest(_ request: URLRequest, completion: @escaping (Result<Data, APIServiceError>) -> (Void)) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.noData))
                return
            }
            
            guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                completion(.failure(.fetchError))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
        return task
    }
}
