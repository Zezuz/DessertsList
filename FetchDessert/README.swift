//
//  README.swift
//  FetchDessert
//
//  Created by Michael Zanaty on 7/3/23.
//


//There are 2 main ViewControllera the DessertViewController which is the main landing page, it is a tableView that shows a list of desserts pulled using this API: https://themealdb.com/api/json/v1/1/filter.php?c=Dessert, the full api call using this is in the file HttpFactory
//On this dessertViewController it shows a list of meal opbjects that each contain a strMeal and an idMeal, when you click on a dessert it send the idMeal of that dessert to the 2nd main ViewController, called DessertInfoViewController, calls another API call from HTTPfactory that uses the idMeal from the meal dessert object that is passed as a string from the object on dessertViewController
//This api call uses "https://themealdb.com/api/json/v1/1/lookup.php?i=\(dessertId)") and the idMeal from the object clicked on in the tableView, it uses this api to pull back a full object from the struct Meals, it pulls back this information and saves it in dessertInfo I then use that info to change the text of several labels one for instructions one for the name and one for the ingredients.

