//
//  EditContactViewController.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 24/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

protocol UpdateContactDelegate: class {
    func updateContact(with contact: ContactResponseModelElement)
}

class UpdateContactViewController: UIViewController {
    
    @IBOutlet weak var displayPictureImageView: UIImageView?
    @IBOutlet weak var headerView: UIView?
    @IBOutlet weak var firstNameTextField: UITextField?
    @IBOutlet weak var lastNameTextField: UITextField?
    @IBOutlet weak var mobileTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?
    
    @IBOutlet weak var cancelButton: UIButton?
    @IBOutlet weak var saveButton: UIButton?
    
    weak var updateContactDelegate: UpdateContactDelegate?
    
    var contactData: ContactResponseModelElement.Attributes?
    let fetchContactService = FetchContactService()
    let viewModel = UpdateAndEditViewModel()
    
    var firstName, lastName, email, phoneNumber: String?
    
    enum State {
        case create
        case update
    }
    
    var currentState: State = .create
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenSetup()
        textFieldsSetup()
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
    
    private func screenSetup() {
        //let darkGradientColor =
       // headerView?.applyGradientLayer(.white, darkGradientColor)
    }
    
    private func textFieldsSetup() {
        firstNameTextField?.delegate = self
        firstNameTextField?.addTarget(self, action: #selector(firstNameTextFieldChanged), for: .editingChanged)
        
        lastNameTextField?.delegate = self
        lastNameTextField?.addTarget(self, action: #selector(lastNameTextFieldChanged), for: .editingChanged)
        
        mobileTextField?.delegate = self
        mobileTextField?.addTarget(self, action: #selector(phoneNumberTextFieldChanged), for: .editingChanged)
        
        emailTextField?.delegate = self
        emailTextField?.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
    }
    
    private func addObserverForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        switch currentState {
        case .create:
            guard isValidForCreateContact() else {
                Utility.showAlert(title: Constants.error, message: Constants.Errors.phoneOrEmailInvalid, onController: self)
                return
            }
            createContact()
        case .update:
            guard isValidForUpdateContact() else {
                Utility.showAlert(title: Constants.error, message: Constants.Errors.phoneOrEmailInvalid, onController: self)
                return
            }
            updateContact()
        }
    }

    private func createContact() {
        let attributes = ContactResponseModelElement.Attributes.init(firstName: firstName!, lastName: lastName!, profilePic: "/images/missing.png", email: email!, phoneNumber: phoneNumber!, url: nil, favorite: false)
        
        let creationModel = ContactCreateModel.init(model: attributes)
        
        fetchContactService.createOrUpdateContact(with: .createNewContact(model: creationModel), completionHandler: { [weak self] result in
            guard let sself = self else { return }
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    Utility.showAlert(title: Constants.error, message: error.errorMessage, onController: sself)
                }
            case .success(let contact):
                DispatchQueue.main.async {
                    sself.updateContactDelegate?.updateContact(with: contact)
                    sself.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
    
    private func updateContact() {
        
        let attributes = ContactResponseModelElement.Attributes.init(firstName: (firstNameTextField?.text)!, lastName: (lastNameTextField?.text)!, profilePic: "/images/missing.png", email: (emailTextField?.text)!, phoneNumber: (mobileTextField?.text)!, url: nil, favorite: false)
        //let newContact = ContactResponseModelElement.init(model: attributes, id: ContactResponseModelElement.id, createdAt: nil, updatedAt: nil)
       // let updateModel =
        
      // ContactResponseModelElement.init(model: attributes, id: ContactResponseModelElement.id, createdAt: nil, updatedAt: nil)
    }
}


extension UpdateContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func firstNameTextFieldChanged(textField: UITextField) {
        firstName = textField.text
    }
    
    @objc func lastNameTextFieldChanged(textField: UITextField) {
        lastName = textField.text
    }
    
    @objc func emailTextFieldChanged(textField: UITextField) {
        email = textField.text
    }
    
    @objc func phoneNumberTextFieldChanged(textField: UITextField) {
        phoneNumber = textField.text
    }
}

// MARK: Keyboard handling
extension UpdateContactViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let height = view.frame.height - (mobileTextField?.frame.origin.y ?? 0)
            
            if height < keyboardSize.height {
                UIView.animate(withDuration: 0.3, animations: {
                     self.view.frame.origin.y -= keyboardSize.height
                })
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

// MARK: UI Validations
extension UpdateContactViewController {
    private func isValidForCreateContact() -> Bool {
        guard let _ = firstName,
            let _ = lastName,
            let email = email,
            let phoneNumber = phoneNumber else {
                Utility.showAlert(message: "Please Enter all fields", onController: self)
                return false
        }
        return viewModel.isValidEmailAddress(email) &&  viewModel.isValidPhoneNumber(phoneNumber)
    }
    
    private func isValidForUpdateContact() -> Bool {
        guard let firstName = firstNameTextField?.text, !firstName.isEmpty,
            let lastName = lastNameTextField?.text, !lastName.isEmpty,
            let email = emailTextField?.text, !email.isEmpty,
            let mobile = mobileTextField?.text, !mobile.isEmpty else {
                Utility.showAlert(message: "Please Enter all fields", onController: self)
                return false
        }
        
        return viewModel.isValidEmailAddress(email) && viewModel.isValidPhoneNumber(mobile)
    }
}
