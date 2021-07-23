//
//  HomeTableViewCell.swift
//  FoodyCookBook
//
//  Created by Ravindran on 22/07/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    static let cellIdentifier = "HomeTableViewCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var cuisine: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var youTubeButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    
    open var youTubeSelected: (() -> Void)?
    open var favouriteSelected: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func didSelectYoutube() {
        youTubeSelected?()
    }
    
    @IBAction func didSelectFavourite() {
        favouriteSelected?()
    }
    
}
