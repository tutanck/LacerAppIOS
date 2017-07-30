//
//  UserServiceDetailsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 19/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserServiceDetailsTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate{
    
    // MARK: - TextField
    
    @IBOutlet weak var titleTextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()         // Hide the keyboard
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) { showRightBarButtonItem() }
    
    
    // MARK: - TextView
    
     
    @IBOutlet weak var descriptionTextView: UITextView!
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()         // Hide the keyboard
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) { showRightBarButtonItem() }

    
    
    
    // MARK: - Switchs
    
    @IBOutlet weak var makeSwitch: UISwitch!
    @IBAction func makeSwitchChanged(_ sender: UISwitch) { showRightBarButtonItem() }
    
    @IBOutlet weak var teachSwitch: UISwitch!
    @IBAction func teachSwitchChanged(_ sender: UISwitch) { showRightBarButtonItem() }
    
    @IBOutlet weak var adviseSwitch: UISwitch!
    @IBAction func adviseSwitchChanged(_ sender: UISwitch) { showRightBarButtonItem() }
    
    
    
    // MARK: - related skills tableView
    
    @IBOutlet weak var relatedSkillsTableView: UITableView!
    
    var relatedSkillsTableViewDelegate : RelatedSkillsTableViewDelegate!

    
    
    // MARK: - System Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        relatedSkillsTableViewDelegate = RelatedSkillsTableViewDelegate()
        relatedSkillsTableView.delegate = relatedSkillsTableViewDelegate
        relatedSkillsTableView.dataSource = relatedSkillsTableViewDelegate
        
        begin()
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

    
    
    
    
    
    // MARK: - private methods
    
    private func begin(){
        hideRightBarButtonItem()
        
        titleTextField.delegate = self
        descriptionTextView.delegate = self
    }
    
    private func hideRightBarButtonItem(){
        if let rightBarButton = self.navigationItem.rightBarButtonItem {
            rightBarButton.isEnabled = false
        }
    }
    
    private func showRightBarButtonItem(){
        if let rightBarButton = self.navigationItem.rightBarButtonItem {
            rightBarButton.isEnabled = true
        }
    }

}


class RelatedSkillsTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    let relatedSkills : [String] = ["Java", "Ada", "Node", "Scrum", "Ruby"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.relatedSkills.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
        
        // set the text from the data model
        cell.textLabel?.text = self.relatedSkills[indexPath.row]
        
        return cell
    }

}
