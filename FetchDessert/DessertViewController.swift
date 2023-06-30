//
//  ViewController.swift
//  FetchDessert
//
//  Created by Michael Zanaty on 6/27/23.
//

import UIKit


class DessertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var dessertTableView: UITableView!
    
    
    
    var desserts: [Meal] = []
    var dessertInfo: Meals?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dessertTableView.delegate = self
        dessertTableView.dataSource = self
        
        fetchDesserts { desserts in
            if let desserts = desserts {
                self.desserts = desserts
                DispatchQueue.main.async {
                    self.dessertTableView.reloadData()
                }
                
            } else {
                print("Failed to fetch desserts.")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return desserts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DessertCell", for: indexPath)
        cell.textLabel?.text = desserts[indexPath.row].strMeal
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDessert = desserts[indexPath.row]
        let selectedDessertId = selectedDessert.idMeal
        
        performSegue(withIdentifier: "segueDessert", sender: selectedDessert)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDessert" {
            if let destinationVC = segue.destination as? DessertInfoViewController,
               let dessert = sender as? Meal {
                destinationVC.selectedDessertID = dessert.idMeal
            }
        }
    }
    
    //
    //
    //
    //
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
    //
    //
    //    }
    
    struct Meal {
        let strMeal: String
        let idMeal: String?
    }
}
