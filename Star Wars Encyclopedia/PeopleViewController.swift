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
    var people = [NSDictionary]()
    var url = URL(string: "http://swapi.co/api/people/")
    
    @IBAction func unwindToPeople(_ segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getApiData(thisUrl: url!)
    }
    
    func getApiData(thisUrl: URL) {
        StarWarsModel.getAllPeople(url: thisUrl, completionHandler: {
            data, response, error in
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if (jsonResult["next"] as? NSNull) != nil {
                        print ("it's null")
                    }
                    if let newURL = jsonResult["next"] as? String {
                        self.url = URL(string: newURL )
                        print (self.url!)
                        self.getApiData(thisUrl: URL(string: newURL )!)
                    }
                    if let results = jsonResult["results"] {
                        // coercing the results object as an NSArray and then storing that in resultsArray
                        let resultsArray = results as! NSArray
                        // now we can run NSArray methods like count and firstObject
                        //
                        for person in resultsArray {
                            let personDict = person as! NSDictionary
                            print(personDict["name"]!)
//                            self.people.append(personDict["name"]! as! String)
                            self.people.append(personDict)
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
        return people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = people[indexPath.row]["name"] as? String
        // return the cell so that it can be rendered
        return cell
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let person = people[indexPath.row]
        performSegue(withIdentifier: "showPeopleDetailsSegue", sender: person)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let person = sender as? NSDictionary
        
        let destination = segue.destination as! PeopleDetailsViewController
        
        destination.person = person
        
    }
}
