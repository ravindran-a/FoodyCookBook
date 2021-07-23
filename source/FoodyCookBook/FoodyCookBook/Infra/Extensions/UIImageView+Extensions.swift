//
//  UIImageView+Extensions.swift
//  FoodyCookBook
//
//  Created by Ravindran on 23/07/21.
//

import Foundation
import UIKit

extension UIImageView {
    
    func imageFromServerURL(urlString: String) {
        
        ApiManager.shared.downloadImage(imageURL: urlString) { image, error in
            self.image = image
        }
    }
    
}
