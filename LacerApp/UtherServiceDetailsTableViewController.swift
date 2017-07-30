//
//  UtherServiceDetailsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 22/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UtherServiceDetailsTableViewController: UITableViewController {

       // MARK: - Properties
    
    @IBOutlet weak var relatedSkillsTableView: UITableView!
    
    var relatedSkillsTableViewDelegate : RelatedSkillsTableViewDelegate!
    
    
    
    // MARK: - System Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        relatedSkillsTableViewDelegate = RelatedSkillsTableViewDelegate()
        relatedSkillsTableView.delegate = relatedSkillsTableViewDelegate
        relatedSkillsTableView.dataSource = relatedSkillsTableViewDelegate
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
