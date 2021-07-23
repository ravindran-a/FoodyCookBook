//
//  Spinner.swift
//  FoodyCookBook
//
//  Created by Ravindran on 22/07/21.
//

import Foundation
import UIKit

public class Spinner: UIActivityIndicatorView {
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.hidesWhenStopped = true
        self.style = .large
        self.color = .blue
        
    }
    
    override public func startAnimating() {
        super.startAnimating()
        self.superview?.isUserInteractionEnabled = false
    }
    
    public func startAnimating(isInteractionEnabled: Bool = false) {
        super.startAnimating()
        self.superview?.isUserInteractionEnabled = isInteractionEnabled
    }
    
    override public func stopAnimating() {
        super.stopAnimating()
        self.superview?.isUserInteractionEnabled = true
    }
    
}
