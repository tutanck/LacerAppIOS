//
//  SwitchableColorButton.swift
//  LacerApp
//
//  Created by Joan Angb on 16/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase


@IBDesignable
class SwitchableColorButton: UIButton {
    
    //MARK: Hard coded Properties
    
    private let messages : [UIColor:String] = [
        .red : "Invisible : Vous ne serez plus visible. Vous ne recevrez pas de notifications.",
        .green : "Disponible : Vous serez visible et prioritaire. Vous recevrez des notifications sonores.",
        .orange : "Occupé : Vous serez toujours visible mais pas prioritaire. Vous recevrez des notifications silencieuses."
    ]
    
    private let colorToInt : [UIColor:Int] = [
        .red : 0,
        .green : 1,
        .orange : 2
    ]
    
    private let intToColor : [Int:UIColor] = [
        0:.red,
        1:.green,
        2:.orange
    ]
    
    private var activated = false
    
    //MARK: Properties
    
    var context : UIViewController?
    
    //MARK: Firef
    
    var ref : DatabaseReference? = nil{
        didSet {
            setupSwitchButton()
        }
    }
    
    
    
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
    
    
    
    //MARK: Initialization & DeInitialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        if let ref = self.ref{
            ref.removeAllObservers()
        }
    }
    
    
    //MARK: Button Action
    func switchColor(button: UIButton) {         //REMINDER : blue : imediatelly available
        
        let nextColor : UIColor = intToColor[(colorToInt[backgroundColor!]!+1)%intToColor.count]!
        
        if context != nil && ref != nil {
            Alert.displayMessage(context: context!,
                                 message: messages[nextColor]!,
                                 handler : { action in self.ref?.setValue(self.colorToInt[nextColor]) },
                                 headerTitle :"Attention!",
                                 cancellable : true)
        }
    }
    
    
    
    //MARK: Private Methods
    
    private func setupSwitchButton() {
        
        if let ref = self.ref {
            ref.observe(.value, with: { snapshot in
                if !snapshot.exists(){
                    // Set the button's default appearence in database
                    self.ref?.setValue(1)
                }else{
                    // Set the button's current appearence
                    self.backgroundColor = self.intToColor[snapshot.value as! Int]
                    
                    if self.activated == false{
                        print("Debug : SwitchableColorButton activated")
                        // Setup the button action
                        self.addTarget(self, action: #selector(SwitchableColorButton.switchColor(button:)), for: .touchUpInside)
                        self.activated = true
                    }
                }
            })
        }
        
        
    }
    
}
