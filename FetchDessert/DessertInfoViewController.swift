//
//  DessertInfoViewController.swift
//  FetchDessert
//
//  Created by Michael Zanaty on 6/27/23.
//

import UIKit

class DessertInfoViewController: UIViewController {
    
    @IBOutlet weak var dessertName: UILabel!
    
    @IBOutlet weak var dessertIngredients: UILabel!
    @IBOutlet weak var dessertInstructions: UILabel!
    var dessertInfo: Meals?
        var selectedDessertID: String?
            
        override func viewDidLoad() {
            super.viewDidLoad()
            print(selectedDessertID)
            
           // dessertName.text = dessertInfo?.strMeal
           //tart and apple frangian not appearing?
            
            fetchDessertInfo(dessertId: selectedDessertID!) { dessertInfo in
                DispatchQueue.main.async {
                    if let dessertInfo = dessertInfo {
                        self.dessertName.text = dessertInfo.strMeal
                        updateIngredientsLabel(with: dessertInfo, in: self.dessertIngredients)
                        self.dessertInstructions.text = dessertInfo.strInstructions
                    } else {
                        print("Failed to fetch dessert info.")
                        // Optionally, show an alert or perform any other action to handle the failure
                    }
                }
            }

        }
        
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
        
        func updateUI() {
            dessertName.text = dessertInfo?.strMeal
            // Update other UI elements using the dessertInfo data
        }
    }
struct DessertInfoResponse: Codable {
    let meals: [Meals]?
}

func updateIngredientsLabel(with dessertInfo: Meals, in label: UILabel) {
    var ingredients = [String]()
    
    // Collect the non-empty ingredient fields
    let mirror = Mirror(reflecting: dessertInfo)
    for child in mirror.children {
        if let propertyName = child.label, propertyName.hasPrefix("strIngredient"),
           let ingredient = child.value as? String,
           let measureProperty = mirror.children.first(where: { $0.label == "strMeasure\(propertyName.suffix(1))" }),
           let measure = measureProperty.value as? String,
           !ingredient.isEmpty
        {
            let ingredientWithMeasure = "\(ingredient) - \(measure)"
            ingredients.append(ingredientWithMeasure)
        }
    }
    
    // Update the label with the concatenated ingredients
    let ingredientsText = ingredients.joined(separator: "\n")
    label.text = ingredientsText
}
