//
//  AccountCheckingViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 24/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class AccountCheckingViewController: UIViewController, UITextFieldDelegate  {
    
    
    //MARK: - Properties
    
    @IBOutlet weak var codeTextField: UITextField!
    
    
    // MARK: - System events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions
    
    @IBAction func connect(_ sender: UIButton) {
        if(true){
            self.present(Gatekeeper.getGate()!, animated: true, completion: nil)
        }else{
            Alert.displayMessage(context: self, message: "can't GO !")
        }
    }
    
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()       // Hide the keyboard.
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
