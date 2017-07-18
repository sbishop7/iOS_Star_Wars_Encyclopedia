//
//  PeopleDetailsViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Seth Bishop on 7/17/17.
//  Copyright © 2017 Seth Bishop. All rights reserved.
//

import Foundation
import UIKit
class PeopleDetailsViewController: UIViewController {

    var person: NSDictionary?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(person!)
        nameLabel.text = person?["name"] as? String
        genderLabel.text = person?["gender"] as? String
        birthYearLabel.text = person?["birth_year"] as? String
        massLabel.text = person?["mass"] as? String
        let speciesArray = person?["species"] as! NSArray
//        print (speciesArray)
        let speciesURL = URL(string: speciesArray[0] as! String)
//        print (speciesURL)
//        speciesLabel.text = speciesURL as? String
//        DispatchQueue.main.async {
        StarWarsModel.getAllPeople(url: speciesURL!, completionHandler: {
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    DispatchQueue.main.async {
                        self.speciesLabel.text = jsonResult["name"] as? String
                    }
                    
//                    if let results = jsonResult["name"] {
//                        print (results)
//                        self.speciesLabel.text = results as? String
////                        self.reloadData()
//                    }
                }
            } catch {
                print (error)
            }
            
            
        })
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
