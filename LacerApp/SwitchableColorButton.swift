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
            
        case UIColor.blue :
            button.backgroundColor = UIColor.green
        case UIColor.green :
            button.backgroundColor = UIColor.orange
        case UIColor.orange :
            button.backgroundColor = UIColor.red
        case UIColor.red :
            button.backgroundColor = UIColor.blue
        default:
            button.backgroundColor = UIColor.green
        }
        
    }
    
    
    
    //MARK: Private Methods
    
    private func setupSwitchButton() {
        
        // Set the button appearence
        self.backgroundColor = UIColor.green
        
        // Setup the button action
        self.addTarget(self, action: #selector(SwitchableColorButton.switchColor(button:)), for: .touchUpInside)
    }

}
