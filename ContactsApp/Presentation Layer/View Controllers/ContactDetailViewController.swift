//
//  ContactDetailViewController.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 24/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    
    @IBOutlet weak var displayPictureImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    
    @IBOutlet weak var mobileDetailLabel: UILabel!
    @IBOutlet weak var emailDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
