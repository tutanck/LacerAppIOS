//
//  CodeVerificationViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 27/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class CodeVerificationViewController: UIViewController, CodeInputViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.99, alpha: 1)
        
        let codeInputViewWidth : CGFloat = 15 + 200 // vary from +-50(input's space) per input
        
        let frame = CGRect(
            x: (view.frame.width - codeInputViewWidth)/2, //centered
            y: 242, //arbitrary
            width: codeInputViewWidth,
            height: 60
        )
        let codeInputView = CodeInputView(frame: frame)
        codeInputView.delegate = self
        view.addSubview(codeInputView)
        codeInputView.becomeFirstResponder()
    }
    
    func codeInputView(_ codeInputView: CodeInputView, didFinishWithCode code: String) {
        
        if code == "1234" {
            self.connect()
        }else{
             Alert.displayMessage(context : self,
             confirmAction: { action in codeInputView.clear() },
             headerTitle : "Code Invalide!",
             confirmButtonTitle : "Réessayer",
             cancellable : true,
             cancelButtonTitle : "Retour",
             cancelAction : { _ in self.dismiss(animated: true, completion: nil) }
            )
        }
        
    }
    
    func connect() {
        self.present(Gatekeeper.getGate()!, animated: true, completion: nil)
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
