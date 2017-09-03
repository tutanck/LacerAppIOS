//
//  Waiter.swift
//  LacerApp
//
//  Created by Joan Angb on 03/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class Waiter {
    
    static func popNServ(
        context : UIViewController,
        dataArray : [Any],
        drink : (Any)->()
        )->(){
        print("Waiter : \(dataArray)") //debug
        if !(dataArray[0] is NSNull){
            isConfused(context)
        }else{
            drink(dataArray[1])
        }
        
    }
    
    
    
    static func isConfused(
        _ context : UIViewController
        ){
        Alert.displayMessage(context: context, headerTitle: "Une erreur s'est produite")
    }
    
}




