//
//  UIViewExtension.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 25/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

extension UIView {
    // BUG - On ipad not working fine - didn't get time to look into it
    func applyGradientLayer(_ lightColor: UIColor, _ darkColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [lightColor.cgColor, darkColor.cgColor]
        gradientLayer.startPoint =  CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
