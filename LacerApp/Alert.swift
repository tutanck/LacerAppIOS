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
    
    
}


