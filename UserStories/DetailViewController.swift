//
//  DetailViewController.swift
//  UserStories
//
//  Created by Igor Karyi on 30.03.2018.
//  Copyright © 2018 Igor Karyi. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class DetailViewController: UIViewController {
    
    var name = String()
    var language = String()
    var stars = String()
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = name
        languageLabel.text = "Язык: \(language)"
        starsLabel.text = "★ \(stars)"
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        saveToCoreData()
    }
    
    func saveToCoreData() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            let repositories = Repositories(context: context)
            repositories.name = name
            repositories.language = language
            repositories.stars = stars
            do {
                try context.save()
                print("save")
            } catch let error as NSError {
                print("error", error)
            }
        }
    }
    
}
