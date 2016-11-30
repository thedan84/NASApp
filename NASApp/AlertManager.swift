//
//  AlertManager.swift
//  NASApp
//
//  Created by Dennis Parussini on 23-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit

struct AlertManager {
    
    //MARK: - Display alert
    static func displayAlert(with title: String?, message: String?, in viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        OperationQueue.main.addOperation {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
