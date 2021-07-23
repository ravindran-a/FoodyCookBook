//
//  Meal.swift
//  FoodyCookBook
//
//  Created by Ravindran on 21/07/21.
//

import Foundation

struct Meal: Codable {

    let idMeal: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try values.decodeIfPresent(String.self, forKey: .idMeal)
        strMeal = try values.decodeIfPresent(String.self, forKey: .strMeal)
        strDrinkAlternate = try values.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        strCategory = try values.decodeIfPresent(String.self, forKey: .strCategory)
        strArea = try values.decodeIfPresent(String.self, forKey: .strArea)
        strInstructions = try values.decodeIfPresent(String.self, forKey: .strInstructions)
        strMealThumb = try values.decodeIfPresent(String.self, forKey: .strMealThumb)
        strTags = try values.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try values.decodeIfPresent(String.self, forKey: .strYoutube)
        strSource = try values.decodeIfPresent(String.self, forKey: .strSource)
        strImageSource = try values.decodeIfPresent(String.self, forKey: .strImageSource)
        strCreativeCommonsConfirmed = try values.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
        dateModified = try values.decodeIfPresent(String.self, forKey: .dateModified)
    }
    
}

struct MealResponse: Codable {
    
    let meals: [Meal]?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        meals = try values.decodeIfPresent([Meal].self, forKey: .meals)
    }
    
}
