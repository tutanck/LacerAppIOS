//
//  ProfileTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 19/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var usernameLabel: UITextField!
    
    @IBOutlet weak var interestTextView: UITextView!

    @IBOutlet weak var unqualifiedSwitch: UISwitch!
    
    @IBOutlet weak var partTimeSwitch: UISwitch!
    
    
    
    
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

}
