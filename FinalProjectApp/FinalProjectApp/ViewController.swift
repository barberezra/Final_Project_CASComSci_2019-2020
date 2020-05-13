//
//  ViewController.swift
//  FinalProjectApp
//
//  Created by Ezra Barber on 5/8/20.
//  Copyright © 2020 Ezra Barber. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   func fetchFilms(completionHandler: @escaping ([Film]) -> Void) {
     let url = URL(string: domainUrlString + "films/")!

     let task  URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
       if let error = error {
         print("Error with fetching films: \(error)")
         return
       }
       
       guard let httpResponse = response as? HTTPURLResponse,
             (200...299).contains(httpResponse.statusCode) else {
         print("Error with the response, unexpected status code: \(response)")
         return
       }

       if let data = data,
         let filmSummary = try? JSONDecoder().decode(FilmSummary.self, from: data) {
         completionHandler(filmSummary.results ?? [])
       }
     })
     task.resume()
   }
    
}

