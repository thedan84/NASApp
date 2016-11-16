//
//  Endpoint.swift
//  NASApp
//
//  Created by Dennis Parussini on 16-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import Foundation

/*
 API Key NASA API: D3z09rlgrrJlvHcp9V4jAYeNAVJib75bBxqyZiFR
 */

enum Endpoint {
    case manifest
    case curiosityPhotos
    
    private var apiKey: String {
        return "D3z09rlgrrJlvHcp9V4jAYeNAVJib75bBxqyZiFR"
    }
    
    private var baseURL: String {
        return "https://api.nasa.gov/"
    }
    
    func urlString() -> String {
        switch self {
        case .manifest: return baseURL + "mars-photos/api/v1/manifests/Curiosity"
        case .curiosityPhotos: return baseURL + "mars-photos/api/v1/rovers/curiosity/photos"
        }
    }
}
