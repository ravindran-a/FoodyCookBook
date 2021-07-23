//
//  ApiManager.swift
//  FoodyCookBook
//
//  Created by Ravindran on 22/07/21.
//

import Foundation
import UIKit

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class ApiManager {
    
    static let shared = ApiManager()
    
    let session = URLSession.shared
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func getRandomMeal(completion: @escaping (MealResponse?, Error?) -> Void) {
        let url = API_BASE_URL + TheMealDBEndPoints.randomLookup.rawValue
        dataTask(serviceURL: url) { response, error in
            if error != nil {
                completion(nil, error)
            } else if let confirmedResponse = response {
                let decoder = JSONDecoder()
                do {
                    let meal = try decoder.decode(MealResponse.self, from: confirmedResponse)
                    print(meal)
                    completion(meal, nil)
                } catch {
                    print(error)
                    completion(nil, error)
                }
            }
        }
    }
    
    func getMealBasedOnMealId(mealId: String, completion: @escaping (MealResponse?, Error?) -> Void) {
        let url = API_BASE_URL + TheMealDBEndPoints.getMeal.rawValue + mealId
        dataTask(serviceURL: url) { response, error in
            if error != nil {
                completion(nil, error)
            } else if let confirmedResponse = response {
                let decoder = JSONDecoder()
                do {
                    let meal = try decoder.decode(MealResponse.self, from: confirmedResponse)
                    print(meal)
                    completion(meal, nil)
                } catch {
                    print(error)
                    completion(nil, error)
                }
            }
        }
    }
    
    func findMealsBasedOnSearchString(searchQuery: String, completion: @escaping (MealResponse?, Error?) -> Void) {
        let url = API_BASE_URL + TheMealDBEndPoints.search.rawValue + searchQuery
        dataTask(serviceURL: url) { response, error in
            if error != nil {
                completion(nil, error)
            } else if let confirmedResponse = response {
                let decoder = JSONDecoder()
                do {
                    let meal = try decoder.decode(MealResponse.self, from: confirmedResponse)
                    print(meal)
                    completion(meal, nil)
                } catch {
                    print(error)
                    completion(nil, error)
                }
            }
        }
    }
    
    private func dataTask(serviceURL: String, httpMethod: HttpMethod = .get, parameters: [String: Any]? = nil,
                          completion: @escaping (Data?, Error?) -> Void) {
        requestData(serviceURL: serviceURL, httpMethod: httpMethod, parameters: parameters, completion: completion)
    }
    
    private func requestData(serviceURL: String, httpMethod: HttpMethod = .get, parameters: [String: Any]? = nil,
                             completion: @escaping (Data?, Error?) -> Void) {
        
        var request = URLRequest(url: URL(string: "\(serviceURL)")!)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        
        if parameters != nil {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
        }
        
        let sessionTask = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, error!)
                }
            }
            
            if data != nil {
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            }
            
        }
        
        sessionTask.resume()
        
    }
    
    func downloadImage(imageURL: String, completion: @escaping (UIImage?, Error?) -> Void) {
        dataTask(serviceURL: imageURL) { imageData, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, error!)
                }
            }
            if let confirmedData = imageData {
                DispatchQueue.main.async {
                    completion(UIImage(data: confirmedData), nil)
                }
            }
        }
    }
    
}
