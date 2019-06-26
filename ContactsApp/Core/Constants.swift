//
//  Constants.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 26/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation
import UIKit

enum Constants {
    
    static let mainStoryBoard = "Main"
    
    static let navigationTitle  = NSLocalizedString("Contact", comment: "")
    static let error = NSLocalizedString("Error", comment: "")
    
    enum Errors {
        static let phoneOrEmailInvalid = NSLocalizedString("Phone number or Email is not valid", comment: "")
        static let allFieldsNotFilled = NSLocalizedString("Please Enter all fields", comment: "")
        static let deCodeError =  NSLocalizedString("cannot able to do encoding", comment: "")
        static let urlError =  NSLocalizedString("url can't be made right now", comment: "")
    }
    
    enum CellIndentifiers {
        static let contactListTableCell = "ContactTableCell"
    }
    
    enum ViewControllers {
        static let editContactVC = "EditContactViewController"
        static let contactDetailVC = "ContactDetailViewController"
    }
    
    enum Colors {
        static let darkGraident = UIColor(red: 218.0/255, green: 245.0/255, blue: 239.0/255, alpha: 1.0)
    }
}

