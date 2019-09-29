//
//  MainViewController.swift
//  NASApp
//
//  Created by Dennis Parussini on 30-11-16.
//  Copyright © 2016 Dennis Parussini. All rights reserved.
//

import UIKit
import ContactsUI
//import KRProgressHUD

class MainViewController: UIViewController, CNContactPickerDelegate {
    
    //MARK: - Properties
    let photoManager = PhotoManager()

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - IBActions
    @IBAction func eyeInTheSkyButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Search for...", message: nil, preferredStyle: .actionSheet)
        
        let contactAction = UIAlertAction(title: "a contact", style: .default) { contactAction in
            let contactsUI = CNContactPickerViewController()
            contactsUI.delegate = self
            
            contactsUI.displayedPropertyKeys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPostalAddressesKey]
            
            self.present(contactsUI, animated: true, completion: nil)
        }
        
        let addressAction = UIAlertAction(title: "an address", style: .default) { addressAction in
            let alert = UIAlertController(title: "Please enter an address", message: nil, preferredStyle: .alert)
            
            let searchAction = UIAlertAction(title: "Search", style: .default) { searchAction in
                let textField = alert.textFields!.first! as UITextField
                if let text = textField.text {
//                    KRProgressHUD.show()
                    self.photoManager.fetchImage(for: text) { photo, error in
                        guard let photo = photo else {
//                            KRProgressHUD.dismiss()
                            AlertManager.displayAlert(with: "Error", message: "Couldn't load photo for this location", in: self)
                            return
                        }
                        
                        let imageVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
                        imageVC.photo = photo
                        
//                        KRProgressHUD.dismiss()
                        
                        self.navigationController?.pushViewController(imageVC, animated: true)
                    }
                }
            }
            searchAction.isEnabled = false
            
            alert.addTextField() {textField in
                textField.placeholder = "Rome, Italy"
                NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using: { (notification) in
                    searchAction.isEnabled = textField.text != nil
                })
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(searchAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(contactAction)
        alert.addAction(addressAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - CNContactPickerDelegate
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
//        KRProgressHUD.show()
        photoManager.fetchImage(for: contact) { photo, error in
            guard let photo = photo else {
//                KRProgressHUD.dismiss()
                AlertManager.displayAlert(with: "Error", message: "Error fetching photos", in: self)
                return
            }
            
            let imageVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
            imageVC.photo = photo
            
//            KRProgressHUD.dismiss()
            
            self.navigationController?.pushViewController(imageVC, animated: true)
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
