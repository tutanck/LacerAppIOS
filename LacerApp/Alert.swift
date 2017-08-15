//
//  Alert.swift
//  LacerApp
//
//  Created by Joan Angb on 14/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class Alert {
    
    static func displayMessage(
        context : UIViewController,
        message : String
        ){
        
        let alert = UIAlertController (title : "Message", message : message, preferredStyle : .alert)
        
        alert.addAction( UIAlertAction(title: "OK" , style: .default, handler: nil) )
        
        context.present(alert, animated: true, completion: nil)
        
    }
    
    
    static func displayMessage(
        context : UIViewController,
        message : String,
        handler : ((UIAlertAction) -> Swift.Void)? = nil,
        completion : (() -> Swift.Void)? = nil,
        headerTitle : String? = "Message",
        confirmButtonTitle : String? = "OK",
        cancellable : Bool? = false,
        cancelButtonTitle : String? = "Annuler",
        alertControllerPreferredStyle : UIAlertControllerStyle = .alert,
        alertActionStyle : UIAlertActionStyle = .default,
        animated : Bool = true
        ){
        
        let alert = UIAlertController (title : headerTitle, message : message, preferredStyle : .alert)
        
        //Cancel action
        if cancellable == true{
            alert.addAction( UIAlertAction(title: cancelButtonTitle, style: .default) )
        }
        
        //Confirm action
        alert.addAction( UIAlertAction(title: confirmButtonTitle , style: .default, handler: handler) )
        
        context.present(alert, animated: animated, completion: nil)
    }
    
    
    
    static func displayTextBox(
        context : UIViewController,
        message : String,
        handler : ((String) -> Swift.Void)? = nil,
        completion : (() -> Swift.Void)? = nil,
        headerTitle : String? = "Message",
        confirmButtonTitle : String? = "OK",
        cancelButtonTitle : String? = "Annuler",
        textBoxText : String? = nil,
        alertControllerPreferredStyle : UIAlertControllerStyle = .alert,
        alertActionStyle : UIAlertActionStyle = .default,
        animated : Bool = true
        ){
        
        let alert = UIAlertController (title : headerTitle, message : message, preferredStyle : .alert)
        
        //TextField
        alert.addTextField()
        
        if let textBoxText = textBoxText{
            alert.textFields?.first?.text = textBoxText
        }
        
        //Cancel action
        alert.addAction( UIAlertAction(title: cancelButtonTitle, style: .default) )
        
        //Confirm action
        alert.addAction(
            UIAlertAction(title: confirmButtonTitle , style: .default){ action in
                
                if let handler = handler {
                    
                    guard let textField = alert.textFields?.first, let text = textField.text else { return }
                    
                    handler(text)
                }
            }
            
        )
        
        context.present(alert, animated: animated, completion: nil)
    }
    
}


