//
//  WelcomeViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 24/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UITextFieldDelegate {
    
    
    //MARK: - Properties
    
    var isDeviceVerifiedForThisUserID = false
    
    @IBOutlet weak var useridTextField: UITextField!
    
    
    // MARK: - System events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.99, alpha: 1)
        
        
        // Handle the text fields user input through delegate callbacks.
        useridTextField.delegate = self
    }
    
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  // Hide the keyboard.
        return true
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func connectOrGoToAccountChecking(_ sender: UIButton) {
        
        //TODO :  update device verification status here
        
        let userid = useridTextField.text!;
        
        if (userid.isEmpty /*TODO add checking rules */) {
            Alert.displayMessage(context: self, message: "Votre numéro de téléphone n'est pas valide")
        }
        if(isDeviceVerifiedForThisUserID){
            Alert.displayMessage(context: self, message: "Connect")
        }else{
            Alert.displayMessage(context: self, message: "Un code de vérification sera envoyé à "+userid, confirmAction : { action in self.performSegue(withIdentifier: "segueFromWelcomeToCodeVerification", sender: self)
            })
        }
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
