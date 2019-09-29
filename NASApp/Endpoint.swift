//
//  Endpoint.swift
//  NASApp
//
//  Created by Dennis Parussini on 16-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

enum Endpoint {
    
    //MARK: - Enum cases
    case manifest
    case curiosityPhotos
    case earth
    
    //MARK: - Computed properties
    private var apiKey: String {
        return "D3z09rlgrrJlvHcp9V4jAYeNAVJib75bBxqyZiFR"
    }
    
    private var baseURL: String {
        return "https://api.nasa.gov/"
    }
    
    //MARK: - URL string for enum case
    func urlString(with parameters: JSON?) -> URL? {
        switch self {
        case .manifest: return URL(string: baseURL + "mars-photos/api/v1/manifests/Curiosity?api_key=\(apiKey)")
        case .curiosityPhotos:
            guard let params = parameters, let sol = params["sol"] as? Int else { return nil }
            
            return URL(string: baseURL + "mars-photos/api/v1/rovers/curiosity/photos?api_key=\(apiKey)&sol=\(sol)")
        case .earth:
            guard let params = parameters, let latitude = params["latitude"] as? Double, let longitude = params["longitude"] as? Double else { return nil }
    
            return URL(string: baseURL + "planetary/earth/imagery/?api_key=\(apiKey)&lat=\(latitude)&lon=\(longitude)")
        }
    }
}
