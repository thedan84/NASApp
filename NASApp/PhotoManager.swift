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
    let contactManager = ContactManager()
    
    func fetchLatestMarsImages(completion: @escaping ([String]?, Error?) -> Void) {
        networkManager.request(endpoint: .manifest, parameters: nil) { result in
            switch result {
            case .success(let json):
                if let manifestDict = json?["photo_manifest"] as? JSON, let maxSol = manifestDict["max_sol"] as? Int {
                    self.networkManager.request(endpoint: .curiosityPhotos, parameters: ["sol": maxSol]) { json in
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
            case .failure(let error): completion(nil, error)
            }
        }
    }
    
    func fetchEarthImage(for address: String, completion: @escaping (String?, Error?) -> Void) {
        geocoder.geocodeAddress(for: address) { location, error in
            
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
    
    func fetchImage(for name: String, completion: @escaping (String?, Error?) -> Void) {
        contactManager.searchLocationForContact(with: name) { location, error in
            
            guard let location = location else { return }
            
            self.networkManager.request(endpoint: .earth, parameters: ["latitude": location.coordinate.latitude, "longitude": location.coordinate.longitude]) { result in
                switch result {
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
