//
//  ContactListViewController.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 23/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {

    @IBOutlet weak var contactListTableView: UITableView?
    @IBOutlet weak var alphabetListStackView: UIStackView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    var contactDataSource = [ContactListCellModel]()
    let fetchContactService = FetchPhotoService()
    var _tableRowHeight: CGFloat = 64.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Contacts"
        setupTableView()
        fetchContacts()
    }
    
    private func screenSetup() {
        activityIndicator?.startAnimating()
        contactListTableView?.isHidden = true
    }
    
    private func setupTableView() {
        let nib = UINib.init(nibName: "ContactTableCell", bundle: nil)
        contactListTableView?.register(nib, forCellReuseIdentifier: "ContactTableCell")
    }

    private func fetchContacts() {
        fetchContactService.fetchContacts(with: .fetchContacts, completionHandler: { [weak self] result in
            guard let sSelf = self else { return }
            switch result {
            case .failure(let error):
                print(error)
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
            }
        })
    }
    
    private func sortTheContacts(in data: inout [ContactListCellModel]) {
        data.sort(by: { $0.name < $1.name })
    }
}

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return contactDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "ContactTableCell", for: indexPath)
        if let cell = tableCell as? ContactTableCell {
            cell.configureCell(with: contactDataSource[indexPath.row])
        }
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return _tableRowHeight
    }
}
