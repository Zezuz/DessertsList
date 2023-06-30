//
//  Common.swift
//  FetchDessert
//
//  Created by Michael Zanaty on 6/29/23.
//


//common functions
//import Foundation
//
//func callMe<T: Decodable>(url: URL, idMeal: Int? = nil, completion: @escaping (Result<T, Error>) -> Void) {
//    var request = URLRequest(url: url)
//
//    // Set request parameters if provided
//    if let idMeal = idMeal {
//        let jsonData = try? JSONSerialization.data(withJSONObject: )
//        request.httpBody = jsonData
//    }
//
//    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//        if let error = error {
//            completion(.failure(error))
//            return
//        }
//
//        if let data = data {
//            do {
//                let decoder = JSONDecoder()
//                let result = try decoder.decode(T.self, from: data)
//                completion(.success(result))
//            } catch {
//                completion(.failure(error))
//            }
//        } else {
//            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
//        }
//    }
//
//    task.resume()
//}
