//
//  SwitchableColorButton.swift
//  LacerApp
//
//  Created by Joan Angb on 16/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


@IBDesignable
class SwitchableColorButton: UIButton {
    
    var context : UIViewController? = nil
    
    //MARK: Interfacce Builder settings
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor : UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSwitchButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSwitchButton()
    }
    
    
    
    //MARK: Button Action
    
    func switchColor(button: UIButton) {
        
        switch button.backgroundColor! {
            
        //case UIColor.blue : attemptToSwitchColor(button,.green )
        case UIColor.green : attemptToSwitchColor(button,.orange, "Vous serez toujours visible mais pas prioritaire. Vous recevrez des notifications silencieuses.")
        case UIColor.orange : attemptToSwitchColor(button,.red,"Vous ne serez plus visible. Vous ne recevrez pas de notifications.")
        //case UIColor.red : attemptToSwitchColor(button,.blue )
        default : attemptToSwitchColor(button,.green, "Vous serez visible et prioritaire. Vous recevrez des notifications sonores.")
            
        }
        
    }
    
    
    
    //MARK: Private Methods
    
    
    private func attemptToSwitchColor(_ button : UIButton, _ newColor : UIColor, _ msg : String){
        if context != nil {
            Alert.displayMessage(context: context!,
                                 message: msg,
                                 handler : { action in button.backgroundColor = newColor },
                                 headerTitle :"Attention!",
                                 cancellable : true
            )
        }else{
            button.backgroundColor = newColor
        }
    }
    
    
    private func setupSwitchButton() {
        
        // Set the button appearence
        self.backgroundColor = UIColor.green
        
        // Setup the button action
        self.addTarget(self, action: #selector(SwitchableColorButton.switchColor(button:)), for: .touchUpInside)
    }
    
}
