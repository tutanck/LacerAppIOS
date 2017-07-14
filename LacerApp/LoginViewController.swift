//
//  LoginViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 14/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate{
    
    //MARK: - Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    

    // MARK: - System events

    override func viewDidLoad() {
        super.viewDidLoad()

        // Handle the text fields user input through delegate callbacks.
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Actions
    
    @IBAction func login(_ sender: UIButton) {
        
        let email = emailTextField.text;
        let pass = passwordTextField.text;
        
        if email!.isEmpty || pass!.isEmpty {
            Alert.displayMessage(context: self, message: "Tous les champs sont requis")
        }
        
        
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
