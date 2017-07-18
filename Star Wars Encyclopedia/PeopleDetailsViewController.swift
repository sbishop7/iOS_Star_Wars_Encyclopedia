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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = person?["name"] as? String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
