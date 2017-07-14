//
//  AccountConfirmationViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 14/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class AccountConfirmationViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    
    @IBOutlet weak var codeTextField: UITextField!
    

    // MARK: - System events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Handle the text fields user input through delegate callbacks.
        codeTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions
    
    @IBAction func confirm(_ sender: UIButton) {
        
    }
    

    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
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
