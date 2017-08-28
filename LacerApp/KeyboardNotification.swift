//
//  KeyboardNotification.swift
//  LacerApp
//
//  Created by Joan Angb on 24/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class KeyboardNotification {
    
    static func addObserverOnKeyboardWillShow (observer : Any, selector : Selector){
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    
    static func addObserverOnKeyboardWillHide (observer : Any, selector : Selector){
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    static func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification, scrollView : UIScrollView ) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 5) * (show ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
}
