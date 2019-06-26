//
//  ViewModelProtocols.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 26/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

protocol ViewModelProtocols {
     func isValidPhoneNumber(_ number: String) -> Bool
     func isValidEmailAddress(_ email: String) -> Bool
}
