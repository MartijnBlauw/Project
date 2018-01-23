//
//  PlaceController.swift
//  BoozeYourCredit
//
//  Created by Martijn Blauw on 22-01-18.
//  Copyright © 2018 Martijn Blauw. All rights reserved.
//

import Foundation
import Firebase
import UIKit


class PlaceController {
    
    // Shared static is used to share the placeController among viewcontrollers.
    static let shared = PlaceController()
    
    func loadCafes(completion: @escaping ([PlaceLocation]?) -> Void) {
        let url = URL(string: "https://api.eet.nu/venues?query=cafes")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let cafes = try? jsonDecoder.decode(PlaceLocations.self, from: data) {
                completion(cafes.results)
                print(cafes)
//                print(cafes.results.first?.location)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
            }
        }
        
        task.resume()
    }
}

