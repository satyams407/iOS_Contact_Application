//
//  UpdateAndEditViewModel.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 25/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

struct UpdateAndEditViewModel: ViewModelProtocols  {
    
    func isValidPhoneNumber(_ number: String) -> Bool {
        return number.count == 10
    }
    
    func isValidEmailAddress(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
