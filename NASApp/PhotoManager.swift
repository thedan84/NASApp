//
//  PhotoManager.swift
//  NASApp
//
//  Created by Dennis Parussini on 20-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

struct PhotoManager {
    
    let networkManager = NetworkManager()
    let geocoder = Geocoder()
    
    func fetchLatestMarsImages(completion: @escaping ([String]?, Error?) -> Void) {
        networkManager.request(endpoint: .curiosityPhotos, parameters: ["sol": 1000]) { json in
            switch json {
            case .success(let object):
                if let jsonArray = object?["photos"] as? JSONArray {
                    var photoStrings = [String]()
                    for json in jsonArray {
                        if let photoString = json["img_src"] as? String {
                            photoStrings.append(photoString)
                        }
                    }
                    completion(photoStrings, nil)
                }
            case .failure(let error): completion(nil, error)
            }
        }
    }
    
    func fetchEarthImage(for address: String, completion: @escaping (String?, Error?) -> Void) {
        geocoder.geocodeAddress(for: address) { location in
            
            guard let location = location else { return }
            
            self.networkManager.request(endpoint: .earth, parameters: ["latitude": location.coordinate.latitude, "longitude": location.coordinate.longitude]) { json in
                
                switch json {
                case .success(let object):
                    if let json = object?["url"] as? String {
                        completion(json, nil)
                    }
                
                case .failure(let error): completion(nil, error)
                }
            }
        }
    }
}
