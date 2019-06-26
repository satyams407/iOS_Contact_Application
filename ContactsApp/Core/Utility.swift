//
//  Utility.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 25/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

struct Utility {
    static func showAlert(title: String = "", message: String, onController controller: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let dismissAction = UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(dismissAction)
            controller.present(alert, animated: true, completion: nil)
        }
    }
}
