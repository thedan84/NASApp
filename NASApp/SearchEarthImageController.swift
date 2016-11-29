//
//  SearchEarthImageController.swift
//  NASApp
//
//  Created by Dennis Parussini on 29-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit
import ContactsUI

class SearchEarthImageController: UIViewController, CNContactPickerDelegate {
    
    let photoManager = PhotoManager()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func searchContactButtonTapped(_ sender: UIButton) {
        let contacsUI = CNContactPickerViewController()
        contacsUI.delegate = self
        
        contacsUI.displayedPropertyKeys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPostalAddressesKey]
        
        self.present(contacsUI, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        photoManager.fetchImage(for: contact) { photo, error in
            guard let photo = photo else { return }
            
            let imageVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
            imageVC.photo = photo
            
            self.navigationController?.pushViewController(imageVC, animated: true)
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
