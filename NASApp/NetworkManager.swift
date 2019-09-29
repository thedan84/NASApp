//
//  NetworkManager.swift
//  NASApp
//
//  Created by Dennis Parussini on 16-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]
typealias JSONArray = [JSON]

struct NetworkManager {
    
    //MARK: - Request endpoint
    func request(endpoint: Endpoint, parameters: JSON?, completion: @escaping (Result) -> Void) {
        guard let url = endpoint.urlString(with: parameters) else { return }
        
        print(url.absoluteString)
        
        let session = URLSession(configuration: .default)
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
                OperationQueue.main.addOperation {
                    switch json {
                    case let object as JSON: completion(.success(object))
                    default: break
                    }
                }
            }
        }
        
        task.resume()
    }
}
