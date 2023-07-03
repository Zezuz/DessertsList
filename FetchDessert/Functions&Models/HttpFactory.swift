//
//  HttpFactory.swift
//  FetchDessert
//
//  Created by Michael Zanaty on 6/30/23.
//

import Foundation

class HTTPFactory {
    
    struct Meal {
        let strMeal: String
        let idMeal: String?
    }
    // Mark: - DessertView API call
    
    func fetchDesserts(completion: @escaping ([Meal]?) -> Void) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            //
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let meals = json?["meals"] as? [[String: Any]] {
                        let desserts = meals.compactMap { mealDict -> Meal? in
                            guard let strMeal = mealDict["strMeal"] as? String,
                                  let idMealStr = mealDict["idMeal"] as? String,
                                  let idMeal = String?(idMealStr) else {
                                return nil
                            }
                            return Meal(strMeal: strMeal, idMeal: idMeal)
                        }
                        completion(desserts)
                    } else {
                        print("Unable to parse response")
                        completion(nil)
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    completion(nil)
                }
            } else {
                print("No data received")
                completion(nil)
            }
        }
        
        task.resume()
    }
    // Mark: - DessertInfoView API call
    
    func fetchDessertInfo(dessertId: String, completion: @escaping (Meals?) -> Void) {
        
        
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(dessertId)") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(DessertInfoResponse.self, from: data)
                    
                    if let meals = response.meals, let dessertInfo = meals.first {
                        completion(dessertInfo)
                    } else {
                        print("Unable to parse response")
                        completion(nil)
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    completion(nil)
                }
            } else {
                print("No data received")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
