//
//  DetailFavoritesViewController.swift
//  UserStories
//
//  Created by Igor Karyi on 31.03.2018.
//  Copyright © 2018 Igor Karyi. All rights reserved.
//

import UIKit

class DetailFavoritesViewController: UIViewController {
    
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var starsLbl: UILabel!
    
    var name = String()
    var language = String()
    var stars = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = name
        languageLbl.text = "Язык: \(language)"
        starsLbl.text = "★ \(stars)"
    }
    
}
