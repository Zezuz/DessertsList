//
//  ViewController.swift
//  FetchDessert
//
//  Created by Michael Zanaty on 6/27/23.
//



import UIKit


class DessertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var dessertTableView: UITableView!
    
    let httpFactory = HTTPFactory()
    
    var desserts: [HTTPFactory.Meal] = []
    var dessertInfo: Meals?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dessertTableView.delegate = self
        dessertTableView.dataSource = self
        
        httpFactory.fetchDesserts { [weak self] meals in
            DispatchQueue.main.async {
                if let meals = meals {
                    self?.desserts = meals
                    self?.dessertTableView.reloadData()
                    // Perform any additional UI updates or data handling
                } else {
                    print("Failed to fetch desserts.")
                    // Optionally, show an alert or perform any other action to handle the failure
                }
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
               let dessert = sender as? HTTPFactory.Meal,
               let selectedDessertId = dessert.idMeal {
                destinationVC.selectedDessertID = selectedDessertId
            }
        }
    }
    
    struct Meal {
        let strMeal: String
        let idMeal: String?
    }
}
