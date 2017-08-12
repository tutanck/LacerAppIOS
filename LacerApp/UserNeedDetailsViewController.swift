//
//  UserNeedDetailsViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 12/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserNeedDetailsViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate  {
    
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
    
    
    // MARK: - Switch
    
    @IBOutlet weak var needStatusSwitch: UISwitch!
    @IBAction func needStatusSwitchChanged(_ sender: UISegmentedControl) { showRightBarButtonItem() }
    
    
    // MARK: - Inner Users Results TableView
    
    @IBOutlet weak var matchingProfilesTableView: UITableView!
    
    var matchingProfilesTableViewDelegate : MatchingProfilesTableViewDelegate!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - Inner Users Results TableView
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Tap gesture

    @IBAction func hideKeyboard(_ sender: AnyObject) {
        titleTextField.endEditing(true)
        descriptionTextView.endEditing(true)
    }
    
    
    // MARK: - System Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matchingProfilesTableViewDelegate = MatchingProfilesTableViewDelegate()
        matchingProfilesTableView.delegate = matchingProfilesTableViewDelegate
        matchingProfilesTableView.dataSource = matchingProfilesTableViewDelegate
        matchingProfilesTableViewDelegate.tableView = matchingProfilesTableView
        
        //SearchController parameters
        searchController.searchResultsUpdater = matchingProfilesTableViewDelegate
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        matchingProfilesTableView.tableHeaderView = searchController.searchBar
        
        //SearchController's search bar parameters
        searchController.searchBar.scopeButtonTitles = ["Particuliers","Entreprises"]
        searchController.searchBar.delegate = matchingProfilesTableViewDelegate
        
        begin()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(UserNeedDetailsViewController.keyboardWillShow(_:)),
            name: Notification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(UserNeedDetailsViewController.keyboardWillHide(_:)),
            name: Notification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
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
    
    
    func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 5) * (show ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustInsetForKeyboardShow(false, notification: notification)
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


