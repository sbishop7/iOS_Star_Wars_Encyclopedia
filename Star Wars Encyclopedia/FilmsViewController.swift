//
//  FilmsViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Seth Bishop on 7/17/17.
//  Copyright © 2017 Seth Bishop. All rights reserved.
//

import Foundation
import UIKit
class FilmsViewController: UITableViewController {

    var films = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StarWarsModel.getAllFilms(completionHandler: {
            data, response, error in
                do {
                    // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let results = jsonResult["results"] {
                            
                            // coercing the results object as an NSArray and then storing that in resultsArray
                            let resultsArray = results as! NSArray
                            // now we can run NSArray methods like count and firstObject
                            //
                            for film in resultsArray {
                                let filmDict = film as! NSDictionary
                                print(filmDict["title"]!)
                                self.films.append(filmDict["title"]! as! String)
                            }
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    
                } catch {
                    print(error)
                }

        })
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // if we return - sections we won't have any sections to put our rows in
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return films.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = UITableViewCell()
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = films[indexPath.row]
        // return the cell so that it can be rendered
        return cell
    }

    
}
