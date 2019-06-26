//
//  ContactDetailViewController.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 24/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    @IBOutlet weak var displayPictureImageView: UIImageView?
    
    @IBOutlet weak var headerView: UIView?
    @IBOutlet weak var fullNameLabel: UILabel?
    @IBOutlet weak var favoriteImageView: UIImageView?
    
    @IBOutlet weak var mobileDetailLabel: UILabel?
    @IBOutlet weak var mobileActivityIndicator: UIActivityIndicatorView?
    
    @IBOutlet weak var emailDetailLabel: UILabel?
    @IBOutlet weak var emailActivityIndicator: UIActivityIndicatorView?
    
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
    
    func configureNavigationBar() {
       navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(editContactButtonTapped))
    }
    
    @objc func editContactButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "EditContactViewController") as? UpdateContactViewController {
            vc.contactData = self.contactDetailDataSource?.model
            vc.currentState = .update
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func fetchContactDetail() {
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
    
    func configureContactDetail(from contact: ContactResponseModelElement) {
        mobileDetailLabel?.text = contact.model.phoneNumber
        emailDetailLabel?.text = contact.model.email
        fullNameLabel?.text = contact.model.fullName
        displayPictureImageView?.configureImageView(with: contact.model.profilePic)
        
        if contact.model.favorite {
            favoriteImageView?.image = UIImage.init(named: "favorite")
        } else {
            favoriteImageView?.image = UIImage.init(named: "nonFavorite")
        }
    }
}
