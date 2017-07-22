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
    
    @IBOutlet weak var searchKeyWordsTextField: UITextField!
    
    @IBOutlet weak var gratificationTextField: UITextField!
    
    @IBOutlet weak var placeTextField: UITextField!
    
    @IBOutlet weak var startDateTextField: UITextField!
    
    @IBOutlet weak var endDateTextField: UITextField!
    
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
        
        titleTextField.delegate = self
        
        descriptionTextView.delegate = self
        
        searchKeyWordsTextField.delegate = self
        
        gratificationTextField.delegate = self
        
        placeTextField.delegate = self
        
        startDateTextField.delegate = self
        
        endDateTextField.delegate = self
    
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
