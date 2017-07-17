//
//  ViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Seth Bishop on 7/17/17.
//  Copyright © 2017 Seth Bishop. All rights reserved.
//

import UIKit
class PeopleViewController: UITableViewController {
    // Hardcoded data for now
//    var people = ["Luke Skywalker", "Leia Organa", "Han Solo", "C-3PO", "R2-D2"]
    var people = [String]()
    var url = URL(string: "http://swapi.co/api/people/")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // specify the url that we will be sending the GET request to
//        var url = URL(string: "http://swapi.co/api/people/?page=8")
        // create a URLSession to handle the request tasks
//        var next = true
        getApiData(url: self.url!)
        

    }
    
    func getApiData(url: URL) {
        let session = URLSession.shared
        // create a "data task" to make the request and run completion handler
        let task = session.dataTask(with: url, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            // data -> JSON data, response -> headers and other meta-information, error-> if one occurred
            // "do-try-catch" blocks execute a try statement and then use the catch statement for errors
            do {
                
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    DispatchQueue.main.async {
                        if (jsonResult["next"] as? NSNull) != nil {
                            print ("it's null")
                        }
                        if let newURL = jsonResult["next"] as? String {
                            self.url = URL(string: newURL )
                            print (self.url!)
                            
                            self.getApiData(url: URL(string: newURL )!)
                        }

                        if let results = jsonResult["results"] {
                        
                            // coercing the results object as an NSArray and then storing that in resultsArray
                            let resultsArray = results as! NSArray
                            // now we can run NSArray methods like count and firstObject
                            //
                            for person in resultsArray {
                                let personDict = person as! NSDictionary
                                print(personDict["name"]!)
                                self.people.append(personDict["name"]! as! String)
                            }
                        }
                        
                    self.tableView.reloadData()
                    }
                    
                }
            } catch {
                print(error)
            }
        })
        
        // execute the task and then wait for the response
        // to run the completion handler. This is async!
        
        task.resume()
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
        return people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = UITableViewCell()
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = people[indexPath.row]
        // return the cell so that it can be rendered
        return cell
    }
}
