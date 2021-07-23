//
//  APIEndpoints.swift
//  FoodyCookBook
//
//  Created by Ravindran on 22/07/21.
//

import Foundation

let API_BASE_URL = "https://www.themealdb.com/api/json/v1/1"

public enum TheMealDBEndPoints: String {
    case randomLookup = "/random.php"
    case search = "/search.php?s="
    case getMeal = "/lookup.php?i="
}
