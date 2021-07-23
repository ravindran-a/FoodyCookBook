//
//  HomeViewController.swift
//  FoodyCookBook
//
//  Created by Ravindran on 21/07/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var spinner: Spinner!
    @IBOutlet weak var homeTable: UITableView!
    var mealItems: MealResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTable.register(UINib(nibName: HomeTableViewCell.cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: HomeTableViewCell.cellIdentifier)
        homeTable.register(UINib(nibName: HomeTableViewDetailCell.cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: HomeTableViewDetailCell.cellIdentifier)
        
        homeTable.refreshControl = UIRefreshControl()
        homeTable.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        loadData()
    }
    
    @objc func handleRefresh() {
        self.homeTable.refreshControl?.endRefreshing()
        self.loadData()
    }
    
    func loadData() {
        spinner.startAnimating()
        ApiManager.shared.getRandomMeal { [weak self] response, error in
            self?.spinner.stopAnimating()
            if error != nil {
                
            } else {
                self?.mealItems = response
                self?.homeTable.reloadData()
            }
        }
    }

}

extension HomeViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if mealItems == nil {
            return 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // swiftlint:disable:next force_cast
            let cell = homeTable.dequeueReusableCell(withIdentifier: HomeTableViewCell.cellIdentifier, for: indexPath) as! HomeTableViewCell
            cell.name.text = mealItems?.meals?.first?.strMeal
            cell.category.text = mealItems?.meals?.first?.strCategory
            cell.cuisine.text = mealItems?.meals?.first?.strArea
            cell.tags.text = mealItems?.meals?.first?.strTags
            if let confirmedYoutubeUrl = mealItems?.meals?.first?.strYoutube {
                cell.youTubeButton.isEnabled = true
                cell.youTubeSelected = {
                    UIApplication.shared.open(URL(string: confirmedYoutubeUrl)!)
                }
            } else {
                cell.youTubeButton.isEnabled = false
                cell.youTubeSelected = nil
            }
            
            if var confirmedImageUrl = mealItems?.meals?.first?.strMealThumb {
                confirmedImageUrl += "/preview"
                cell.itemImageView.image = nil
                cell.itemImageView.imageFromServerURL(urlString: confirmedImageUrl)
            }
            
            if FavouritesManager.shared.isFavouriteMeal((mealItems?.meals?.first)!) {
                cell.favouriteButton.isSelected = true
            } else {
                cell.favouriteButton.isSelected = false
            }
            
            cell.favouriteSelected = {
                FavouritesManager.shared.updateFavouriteList((self.mealItems?.meals?.first)!)
                DispatchQueue.main.async {
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }

            return cell
        } else {
            // swiftlint:disable:next force_cast
            let cell = homeTable.dequeueReusableCell(withIdentifier: HomeTableViewDetailCell.cellIdentifier, for: indexPath) as! HomeTableViewDetailCell
            cell.instructions.text = mealItems?.meals?.first?.strInstructions
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250.0
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Random Food of The Day!"
        } else {
            return "Instructions"
        }
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
