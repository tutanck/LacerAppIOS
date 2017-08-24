//
//  KeyboardNotification.swift
//  LacerApp
//
//  Created by Joan Angb on 24/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class KeyboardNotification {
    
    static func keyboardWillShow (observer : Any, selector : Selector){
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    
    static func keyboardWillHide (observer : Any, selector : Selector){
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
}
