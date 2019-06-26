//
//  ContactDetailViewController.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 24/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

protocol RefreshContactList: class {
    func refreshContacts(with contact: ContactResponseModelElement)
}

class ContactDetailViewController: UIViewController, UpdateContactDelegate {

    @IBOutlet weak var displayPictureImageView: UIImageView?
    
    @IBOutlet weak var headerView: UIView?
    @IBOutlet weak var fullNameLabel: UILabel?
    @IBOutlet weak var favoriteImageView: UIImageView?
    
    @IBOutlet weak var mobileDetailLabel: UILabel?
    @IBOutlet weak var mobileActivityIndicator: UIActivityIndicatorView?
    
    @IBOutlet weak var emailDetailLabel: UILabel?
    @IBOutlet weak var emailActivityIndicator: UIActivityIndicatorView?
    
    weak var refreshDelegate: RefreshContactList?
    
    var contactDetailDataSource: ContactResponseModelElement?
    var id: Int?
    let fetchService = FetchContactService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenSetup()
        configureNavigationBar()
        fetchContactDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func screenSetup() {
        displayPictureImageView?.layer.cornerRadius = (displayPictureImageView?.frame.width ?? 0)/2
        displayPictureImageView?.layer.borderWidth = 3.0
        displayPictureImageView?.layer.borderColor = UIColor.white.cgColor
        let darkGradientColor = UIColor(red: 218.0/255, green: 245.0/255, blue: 239.0/255, alpha: 1.0)
        headerView?.applyGradientLayer(.white, darkGradientColor)
        emailActivityIndicator?.startAnimating()
        mobileActivityIndicator?.startAnimating()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(editContactButtonTapped))
    }
    
    @objc func editContactButtonTapped() {
        let storyboard = UIStoryboard(name: Constants.mainStoryBoard, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllers.editContactVC) as? UpdateContactViewController {
            vc.updateContactDelegate = self
            vc.contactData = contactDetailDataSource?.model
            vc.id = contactDetailDataSource?.id
            vc.createdAt = contactDetailDataSource?.createdAt
            vc.currentState = .update
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    private func fetchContactDetail() {
        guard let id = self.id else { return }
        
        fetchService.fetchContact(with: .fetchContact(id: id), completionHandler: {
            [weak self] result in
            guard let sSelf = self else { return }
            switch result {
            case .failure(let error):
                Utility.showAlert(message: error.errorMessage, onController: sSelf)
            case .success(let responseModel):
                DispatchQueue.main.async {
                    sSelf.contactDetailDataSource = responseModel
                    sSelf.configureContactDetail(from: responseModel)
                    sSelf.emailActivityIndicator?.stopAnimating()
                    sSelf.mobileActivityIndicator?.stopAnimating()
                    sSelf.emailActivityIndicator?.isHidden = true
                    sSelf.mobileActivityIndicator?.isHidden = true
                }
            }
        })
    }
    
    private func configureContactDetail(from contact: ContactResponseModelElement) {
        mobileDetailLabel?.text = contact.model.phoneNumber
        emailDetailLabel?.text = contact.model.email
        fullNameLabel?.text = contact.model.fullName
        displayPictureImageView?.downloadFromLink(link: contact.model.profilePic, contentMode: .scaleAspectFit)
        if contact.model.favorite {
            favoriteImageView?.image = UIImage(named: "favorite")
        } else {
            favoriteImageView?.image = UIImage(named: "nonFavorite")
        }
    }
    
    func updateContact(with contact: ContactResponseModelElement) {
        refreshDelegate?.refreshContacts(with: contact)
        contactDetailDataSource = contact
        configureContactDetail(from: contact)
    }
}
