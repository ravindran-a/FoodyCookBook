//
//  SearchViewController.swift
//  FoodyCookBook
//
//  Created by Ravindran on 21/07/21.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var spinner: Spinner!
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResults: UILabel!
    var mealResponse: MealResponse?
    var meals: [Meal]?
    var searchString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTable.register(UINib(nibName: HomeTableViewCell.cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: HomeTableViewCell.cellIdentifier)
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = .search
    }

}

extension SearchViewController {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mealResponse = nil
        meals = nil
        searchTable.reloadData()
        searchString = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchString = searchBar.text
        if searchString == nil || searchString?.isEmpty == true {
            mealResponse = nil
            meals = nil
            searchTable.reloadData()
        } else {
            spinner.startAnimating()
            ApiManager.shared.findMealsBasedOnSearchString(searchQuery: searchString ?? "") { [weak self] response, error in
                self?.spinner.stopAnimating()
                if error != nil {
                    
                } else {
                    self?.mealResponse = response
                    self?.meals = response?.meals
                    self?.searchTable.reloadData()
                    (self?.meals?.count ?? 0) == 0 ? (self?.noResults.isHidden = false) : (self?.noResults.isHidden = true)
                }
            }
        }
    }
    
}

extension SearchViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return meals?.count ?? 0 == 0 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals?.count ?? 0 == 0 ? 0 : (meals?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = searchTable.dequeueReusableCell(withIdentifier: HomeTableViewCell.cellIdentifier, for: indexPath) as! HomeTableViewCell
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
                    tableView.reloadRows(at: [indexPath], with: .automatic)
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
        return "Your Search Results!"
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
