//
//  PhotoManager.swift
//  NASApp
//
//  Created by Dennis Parussini on 20-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit
import Contacts

struct PhotoManager {
    
    let networkManager = NetworkManager()
    let geocoder = Geocoder()
    let contactManager = ContactManager()
    
    func fetchLatestMarsImages(completion: @escaping ([MarsPhoto]?, Error?) -> Void) {
        networkManager.request(endpoint: .manifest, parameters: nil) { result in
            switch result {
            case .success(let json):
                if let manifestDict = json?["photo_manifest"] as? JSON, let maxSol = manifestDict["max_sol"] as? Int {
                    self.networkManager.request(endpoint: .curiosityPhotos, parameters: ["sol": maxSol]) { json in
                        switch json {
                        case .success(let object):
                            if let jsonArray = object?["photos"] as? JSONArray {
                                var photosArray = [MarsPhoto]()
                                for json in jsonArray {
                                    guard let photo = MarsPhoto(json: json) else { return }
                                    
                                    photosArray.append(photo)
                                }
                                completion(photosArray, nil)
                            }
                        case .failure(let error): completion(nil, error)
                        }
                    }
                }
            case .failure(let error): completion(nil, error)
            }
        }
    }
    
    func fetchEarthImage(for address: String, completion: @escaping (EarthPhoto?, Error?) -> Void) {
        geocoder.geocodeAddress(for: address) { location, error in
            
            guard let location = location else { return }
            
            self.networkManager.request(endpoint: .earth, parameters: ["latitude": location.coordinate.latitude, "longitude": location.coordinate.longitude]) { json in
                
                switch json {
                case .success(let object):
                    guard let json = object, let image = EarthPhoto(json: json) else { return }
                    
                    completion(image, nil)
                    
                case .failure(let error): completion(nil, error)
                }
            }
        }
    }
    
    func fetchImage(for contact: CNContact, completion: @escaping (EarthPhoto?, Error?) -> Void) {
        contactManager.searchLocation(for: contact) { location, error in
            guard let location = location else { return }
            
            self.networkManager.request(endpoint: .earth, parameters: ["latitude": location.coordinate.latitude, "longitude": location.coordinate.longitude]) { (result) in
                switch result {
                case .success(let object):
                    guard let json = object, let image = EarthPhoto(json: json) else { return }
                    
                    completion(image, nil)
                    
                case .failure(let error): completion(nil, error)
                }
            }
        }
    }
}
