//
//  NeedTestTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 22/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class NeedTestTableViewController: UITableViewController {

    
    var needs : [Need] = [
        Need(tags : "#Java #lol" , username : "Joana", distance : 200, description : "Chauffeur tout de suite" ,photo : UIImage(named : "userPhoto"), title : "Chauffeur", activ : true),
        Need(tags : "#Java #lol" , username : "Joana", distance : 200, description : "Chauffeur tout de suite" ,photo : UIImage(named : "userPhoto"), title : "Chauffeur", activ : true)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return needs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NeedTableViewCell", for: indexPath) as? NeedTableViewCell  else {
            fatalError("The dequeued cell is not an instance of NeedTableViewCell.")
        }        
        return cell
    }
    
}
