//
//  ContactListViewController.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 23/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit
import Foundation

class ContactListViewController: UIViewController, UpdateContactDelegate, RefreshContactList {

    @IBOutlet weak var contactListTableView: UITableView?
    @IBOutlet weak var alphabetListStackView: UIStackView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    var contactDataSource = [ContactListCellModel]()
    let fetchContactService = FetchContactService()
    var _tableRowHeight: CGFloat = 64.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        screenSetup()
        setupTableView()
        fetchContacts()
        alphabetsStackIntialSetup()
    }
    
    private func screenSetup() {
        activityIndicator?.startAnimating()
        contactListTableView?.isHidden = true
        alphabetListStackView?.isHidden = true
    }
    
    private func setupTableView() {
        let nib = UINib.init(nibName: Constants.CellIndentifiers.contactListTableCell, bundle: nil)
        contactListTableView?.register(nib, forCellReuseIdentifier: Constants.CellIndentifiers.contactListTableCell)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.topItem?.title = Constants.navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addContactButtonTapped))
    }
    
    @objc func addContactButtonTapped() {
        let storyboard = UIStoryboard(name: Constants.mainStoryBoard, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllers.editContactVC) as? UpdateContactViewController {
            vc.currentState = .create
            vc.updateContactDelegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    private func alphabetsStackIntialSetup() {
        let startChar = Unicode.Scalar("A").value
        let endChar = Unicode.Scalar("Z").value
        for value in startChar...endChar {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            alphabetListStackView?.addArrangedSubview(button)
            
            button.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 10.0).isActive = true
            button.setTitle(Unicode.Scalar(value)?.description, for: .normal)
            button.setTitleColor(.darkGray, for: .normal)
            button.tag = Int(value)
            button.addTarget(self, action: #selector(alphabetButtonTapped(_:)), for: .allTouchEvents)
        }
    }
    
    @objc func alphabetButtonTapped(_ sender: UIButton) {
        let tag = sender.tag
        let char: String = Unicode.Scalar(tag)?.description ?? ""
        var indexPath = IndexPath(row: 0, section: 0)
        for idx in 0..<contactDataSource.count {
            let index = contactDataSource.index(contactDataSource.startIndex, offsetBy: idx)
            if contactDataSource[index].name.prefix(1) == char  {
                indexPath = IndexPath(row: idx, section: 0)
                break
            }
        }
        contactListTableView?.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    // MARK: API Call
    private func fetchContacts() {
        fetchContactService.fetchContacts(with: .fetchContacts, completionHandler: { [weak self] result in
            guard let sSelf = self else { return }
            switch result {
            case .failure(let error):
                Utility.showAlert(title: Constants.error, message: error.errorMessage, onController: sSelf)
            case .success(let responseModel):
                for contactModel in responseModel {
                    let cellModel = ContactListCellModel.init(with: contactModel)
                    sSelf.contactDataSource.append(cellModel)
                }
            }
            DispatchQueue.main.async {
                sSelf.sortTheContacts(in: &(sSelf.contactDataSource))
                sSelf.contactListTableView?.reloadData()
                sSelf.activityIndicator?.stopAnimating()
                sSelf.activityIndicator?.isHidden = true
                sSelf.contactListTableView?.isHidden = false
                sSelf.alphabetListStackView?.isHidden = false
            }
        })
    }
    
    private func sortTheContacts(in data: inout [ContactListCellModel]) {
        data.sort(by: { $0.name < $1.name })
    }
    
    func updateContact(with contact: ContactResponseModelElement) {
        let cellModel = ContactListCellModel.init(with: contact)
        contactDataSource.append(cellModel)
        sortTheContacts(in: &(contactDataSource))
        contactListTableView?.reloadData()
    }
    
    func refreshContacts(with contact: ContactResponseModelElement) {
        contactDataSource.removeAll(where: { $0.id == contact.id })
        let newModel = ContactListCellModel.init(with: contact)
        contactDataSource.append(newModel)
        sortTheContacts(in: &contactDataSource)
        self.contactListTableView?.reloadData()
    }
}

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIndentifiers.contactListTableCell, for: indexPath)
        if let cell = tableCell as? ContactTableCell {
            cell.configureCell(with: contactDataSource[indexPath.row])
        }
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return _tableRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Constants.mainStoryBoard, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllers.contactDetailVC) as? ContactDetailViewController {
            vc.id = contactDataSource[indexPath.row].id
            vc.refreshDelegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
