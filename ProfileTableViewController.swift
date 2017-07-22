//
//  ProfileTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 19/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    //SegmentedControl

    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBAction func typeSegmentedControlChanged(_ sender: UISegmentedControl) { showRightBarButtonItem() }
    
    
    //TextField
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()         // Hide the keyboard
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) { showRightBarButtonItem() }
    
    
    //TextView
    
    @IBOutlet weak var interestTextView: UITextView!

    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()         // Hide the keyboard
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) { showRightBarButtonItem() }
    
    
    
    //Switchs
    
    @IBOutlet weak var unqualifiedSwitch: UISwitch!
    @IBAction func unqualifiedSwitchChanged(_ sender: UISwitch) { showRightBarButtonItem() }

    @IBOutlet weak var partTimeSwitch: UISwitch!
    @IBAction func partTimeSwitchChanged(_ sender: UISwitch) { showRightBarButtonItem() }
    
    
    
    
    // MARK: - System Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        //photoImageView
        
        usernameTextField.delegate = self

        //typeSegmentedControl
        
        interestTextView.delegate = self
        
        //unqualifiedSwitch
        
        //partTimeSwitch
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
