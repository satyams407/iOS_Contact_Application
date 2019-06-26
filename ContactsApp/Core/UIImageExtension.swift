//
//  UIImageExtension.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 24/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

var imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    // Note: There is bug that i am not able to solve in given time for this assignment
    // Bug is when we do fast scrolling then sometimes photos at particular indexpath is reassigned with different pic.
    // Alternative:We can use SDWebImage or kingfisher library to have async download of image
    
    // **Additional - Implemented Image Caching**
    func downloadFromLink(link: String, contentMode: UIView.ContentMode) {
        self.image = nil
        let imageURLString = link
        if let imageFromCache = imageCache.object(forKey: link as NSString) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        guard link != "/images/missing.png",  let url = URL(string: link) else {
            self.image = UIImage.init(named: "defaultDP.png")
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) -> Void in
            guard let data = data, error == nil else { return }
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.contentMode = contentMode
                let imageToCache = UIImage(data: data)
                if imageURLString == link {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: link as NSString)
            }
        }).resume()
    }
}
