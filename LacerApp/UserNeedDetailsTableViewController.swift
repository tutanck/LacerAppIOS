//
//  UserNeedDetailsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 22/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserNeedDetailsTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
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
    
    
    
    // MARK: - Inner Users Results TableView
    
    @IBOutlet weak var matchingProfilesTableView: UITableView!
    
    var matchingProfilesTableViewDelegate : MatchingProfilesTableViewDelegate!

    
    // MARK: - System Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchingProfilesTableViewDelegate = MatchingProfilesTableViewDelegate()
        matchingProfilesTableView.delegate = matchingProfilesTableViewDelegate
        matchingProfilesTableView.dataSource = matchingProfilesTableViewDelegate
        
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



class MatchingProfilesTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    let matchingProfiles : [User] = [
        User(name: "Angb joan", photo:UIImage(named: "userPhoto"), status: 1),
        User(name: "Diogo Justino", photo: UIImage(named: "userPhoto"), status: 0),
        User(name: "Tesla", photo: UIImage(named: "userPhoto"), status: 2)
    ]
    
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchingProfiles.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchingProfileTableViewCell") as! MatchingProfileTableViewCell
        
        // set the text from the data model
        cell.photoImageView.image = self.matchingProfiles[indexPath.row].photo
        cell.usernameLabel.text = self.matchingProfiles[indexPath.row].name
        cell.userstatusSpot.backgroundColor = StatusColor.getColor(status : self.matchingProfiles[indexPath.row].status)
        
        return cell
    }
    
}
