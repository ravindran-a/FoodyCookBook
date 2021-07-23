//
//  FavouritesViewController.swift
//  FoodyCookBook
//
//  Created by Ravindran on 21/07/21.
//

import UIKit

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var spinner: Spinner!
    @IBOutlet weak var noResults: UILabel!
    @IBOutlet weak var favouriteTable: UITableView!
    var meals: [Meal]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteTable.register(UINib(nibName: HomeTableViewCell.cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: HomeTableViewCell.cellIdentifier)
        favouriteTable.refreshControl = UIRefreshControl()
        favouriteTable.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    @objc func handleRefresh() {
        self.favouriteTable.refreshControl?.endRefreshing()
        self.loadData()
    }
    
    func loadData() {
        spinner.startAnimating()
        meals = FavouritesManager.shared.getListOfFavourites()
        favouriteTable.reloadData()
        spinner.stopAnimating()
        (meals?.count ?? 0) == 0 ? (noResults.isHidden = false) : (noResults.isHidden = true)
    }
    
}

extension FavouritesViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return meals?.count ?? 0 == 0 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = favouriteTable.dequeueReusableCell(withIdentifier: HomeTableViewCell.cellIdentifier, for: indexPath) as! HomeTableViewCell
        if let meal = meals?[indexPath.row] {
            cell.name.text = meal.strMeal
            cell.category.text = meal.strCategory
            cell.cuisine.text = meal.strArea
            cell.tags.text = meal.strTags
            if let confirmedYoutubeUrl = meal.strYoutube {
                cell.youTubeButton.isEnabled = true
                cell.youTubeSelected = {
                    UIApplication.shared.open(URL(string: confirmedYoutubeUrl)!)
                }
            } else {
                cell.youTubeButton.isEnabled = false
                cell.youTubeSelected = nil
            }
            
            if var confirmedImageUrl = meal.strMealThumb {
                confirmedImageUrl += "/preview"
                cell.itemImageView.image = nil
                cell.itemImageView.imageFromServerURL(urlString: confirmedImageUrl)
            }
            
            if FavouritesManager.shared.isFavouriteMeal(meal) {
                cell.favouriteButton.isSelected = true
            } else {
                cell.favouriteButton.isSelected = false
            }
            
            cell.favouriteSelected = {
                FavouritesManager.shared.updateFavouriteList((meal))
                DispatchQueue.main.async {
                    self.loadData()
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Favourites!"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}
