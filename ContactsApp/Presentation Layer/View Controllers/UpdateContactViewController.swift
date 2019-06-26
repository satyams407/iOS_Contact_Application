//
//  EditContactViewController.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 24/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

class UpdateContactViewController: UIViewController {

    @IBOutlet weak var displayPictureImageView: UIImageView?
    @IBOutlet weak var firstNameTextField: UITextField?
    @IBOutlet weak var lastNameTextField: UITextField?
    @IBOutlet weak var mobileTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?
    
    @IBOutlet weak var cancelButton: UIButton?
    @IBOutlet weak var saveButton: UIButton?
    
    var contactData: ContactResponseModelElement.Attributes?
    let fetchContactService = FetchContactService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetails()
        addObserverForKeyboard()
    }
    
    func configureDetails() {
        guard let contactData = contactData else { return }
        firstNameTextField?.text = contactData.firstName
        lastNameTextField?.text = contactData.lastName
        mobileTextField?.text = contactData.phoneNumber
        emailTextField?.text = contactData.email
    }
    
    private func addObserverForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
    }
    
    private func saveContact() {
        
    }
}


extension UpdateContactViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Keyboard handling
extension UpdateContactViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
