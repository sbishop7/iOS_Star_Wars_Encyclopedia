//
//  FilmDetailsViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Seth Bishop on 7/18/17.
//  Copyright © 2017 Seth Bishop. All rights reserved.
//

import Foundation
import UIKit

class FilmDetailsViewController: UIViewController {
    
    var film: NSDictionary?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var openingCrawlLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = film?["title"] as? String
        releaseDateLabel.text = film?["release_date"] as? String
        directorLabel.text = film?["director"] as? String
        openingCrawlLabel.text = film?["opening_crawl"] as? String
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
