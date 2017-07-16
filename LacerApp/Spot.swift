//
//  SwitchableColorButton.swift
//  LacerApp
//
//  Created by Joan Angb on 16/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


@IBDesignable
class Spot : UIButton {
    
    
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSwitchButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSwitchButton()
    }
    
    
    
    
    
    private func setupSwitchButton() {
        
        // Set the button appearence
        self.backgroundColor = UIColor.red
        
        // Setup the button action
        self.addTarget(self, action: #selector(Spot.chill(button:)), for: .touchUpInside)
    }
    
    
    
    func chill(button: UIButton) {}
    
    
}
