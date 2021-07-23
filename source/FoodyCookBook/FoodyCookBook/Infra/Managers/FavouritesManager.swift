//
//  FavouritesManager.swift
//  FoodyCookBook
//
//  Created by Ravindran on 23/07/21.
//

import Foundation

class FavouritesManager {
    
    static let shared = FavouritesManager()
    
    func getListOfFavourites() -> [Meal]? {
        if let confirmedObject = unArchiveFavouriteMeals() {
            return confirmedObject
        }
        return nil
    }
    
    func isFavouriteMeal(_ meal: Meal) -> Bool {
        if let confirmedObject = unArchiveFavouriteMeals() {
            if let _ = confirmedObject.firstIndex(where: { $0.idMeal == meal.idMeal }) {
                return true
            }
        }
        return false
    }
    
    func updateFavouriteList(_ meal: Meal) {
        if var confirmedObject = unArchiveFavouriteMeals() {
            if let confirmedIndex = confirmedObject.firstIndex(where: { $0.idMeal == meal.idMeal }) {
                confirmedObject.remove(at: confirmedIndex)
                archiveFavouriteMeals(meals: confirmedObject)
            } else {
                confirmedObject.append(meal)
                archiveFavouriteMeals(meals: confirmedObject)
            }
        } else {
            var meals = [Meal]()
            meals.append(meal)
            archiveFavouriteMeals(meals: meals)
        }
    }
    
    private func archiveFavouriteMeals(meals: [Meal]) {
        let data = try? JSONEncoder().encode(meals)
        UserDefaultsManager.setObject(data, forKey: .favourites)
    }
    
    private func unArchiveFavouriteMeals() -> [Meal]? {
        if let unarchivedObject = UserDefaultsManager.objectForKey(.favourites) as? Data {
            return try? JSONDecoder().decode([Meal].self, from: unarchivedObject)
        }
        return nil
    }
    
}
