//
//  ViewController.swift
//  UserStories
//
//  Created by Igor Karyi on 30.03.2018.
//  Copyright © 2018 Igor Karyi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

@available(iOS 10.0, *)
class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userNameField: UITextField!
    
    var userName = String()
    
    var repoArray = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameField.resignFirstResponder()
        return true
    }
    
    //MARK: Actions
    @IBAction func searchAction(_ sender: UIButton) {
        userName = userNameField.text!
        repoRequest()
    }
    
    //MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var dict = repoArray[indexPath.row]
        
        cell.textLabel?.text = dict["name"] as? String
        cell.detailTextLabel?.text = "★ \(dict["stargazers_count"] as! Int)"
        
        return cell
    }
    
    func repoRequest() {
        let queue = DispatchQueue(label: "com.repo.api", qos: .background, attributes: .concurrent)
        
        Alamofire.request("https://api.github.com/users/\(userName)/repos", method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON(queue: queue) { response in
                if (response.result.error == nil) {
                    let json = JSON(response.result.value as Any)
                    if let repo = json[].arrayObject {
                        self.repoArray = repo as! [[String:AnyObject]]
                    }
                }
                else {
                    debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
                    self.repoArray = []
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! DetailViewController
                var dict = repoArray[indexPath.row]
                detailVC.name = (dict["name"] as? String)!
                detailVC.language = (dict["language"] as? String)!
                detailVC.stars = "\(dict["stargazers_count"] as! Int)"
            }
        }
    }
    
}

