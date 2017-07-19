//
//  ServiceDetailsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 19/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class ServiceDetailsTableViewController: UITableViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var makeSwitch: UISwitch!
    
    @IBOutlet weak var teachSwitch: UISwitch!
    
    @IBOutlet weak var adviseSwitch: UISwitch!
    
    @IBOutlet weak var showSkillsButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    
    
    //MARK : Unwind
    
    @IBAction func saveFromManageSkills(segue:UIStoryboardSegue) {}
    
    @IBAction func saveFromSelectRelatedSkills(segue:UIStoryboardSegue) {}



}
