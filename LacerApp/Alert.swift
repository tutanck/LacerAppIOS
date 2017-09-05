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
        headerTitle : String? = "Message",
        message : String?=nil,
        
        confirmable : Bool? = true,
        confirmButtonTitle : String? = "OK",
        confirmAction : ((UIAlertAction) -> Swift.Void)? = nil,
        
        cancellable : Bool? = false,
        cancelButtonTitle : String? = "Annuler",
        cancelAction : ((UIAlertAction) -> Swift.Void)? = nil,
        
        alertControllerPreferredStyle : UIAlertControllerStyle = .alert,
        alertActionStyle : UIAlertActionStyle = .default,
        
        animated : Bool = true,
        completion : (() -> Swift.Void)? = nil,
        
        displayDuration : Double? = 2
        ){
        
        let alert = UIAlertController (title : headerTitle, message : message, preferredStyle : alertControllerPreferredStyle)
        
        
        if confirmable == true{
            
            //Cancel action
            if cancellable == true {
                alert.addAction( UIAlertAction(title: cancelButtonTitle, style: alertActionStyle, handler: cancelAction))
            }
            
            //Confirm action
            alert.addAction( UIAlertAction(title: confirmButtonTitle , style: alertActionStyle, handler: confirmAction) )
       
            context.present(alert, animated: animated, completion: completion)
            
        }else{
            context.present(alert, animated: animated, completion: completion)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + displayDuration!){
                alert.dismiss(animated: animated, completion: completion)
            }
            
        }
        
    }
    
    
    
    static func displayTextBox (
        context : UIViewController,
        headerTitle : String? = "Message",
        message : String,
        
        handler : ((String) -> Swift.Void)? = nil,
        confirmButtonTitle : String? = "OK",
        cancelButtonTitle : String? = "Annuler",
        textBoxText : String? = nil,
        
        alertControllerPreferredStyle : UIAlertControllerStyle = .alert,
        alertActionStyle : UIAlertActionStyle = .default,
        
        animated : Bool = true,
        completion : (() -> Swift.Void)? = nil
        ){
        
        let alert = UIAlertController (title : headerTitle, message : message, preferredStyle : alertControllerPreferredStyle)
        
        //TextField
        alert.addTextField()
        
        if let textBoxText = textBoxText{
            alert.textFields?.first?.text = textBoxText
        }
        
        //Cancel action
        alert.addAction( UIAlertAction(title: cancelButtonTitle, style: alertActionStyle) )
        
        //Confirm action
        alert.addAction(
            UIAlertAction(title: confirmButtonTitle , style: alertActionStyle){ action in
                
                if let handler = handler {
                    
                    guard let textField = alert.textFields?.first, let text = textField.text else { return }
                    
                    handler(text)
                }
            }
            
        )
        
        context.present(alert, animated: animated, completion: completion)
    }
    
    
    
    
}


