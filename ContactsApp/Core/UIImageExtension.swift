//
//  UIImageExtension.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 24/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func configureImageView(with urlString: String) {
        let url = URL(string: urlString)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "defaultDP"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1))
            ])
    }
}
