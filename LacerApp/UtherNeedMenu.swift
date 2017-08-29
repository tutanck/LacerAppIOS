//
//  UtherNeedMenu.swift
//  LacerApp
//
//  Created by Joan Angb on 28/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

@IBDesignable class UtherNeedMenu: UIStackView {
    
    var context : UIViewController?
    
    var needData : [String:String] =
        ["pay": "LOL0","place": "LOL1","time": "LOL2","meta": "LOL3","share": "LOL4","talk": "LOL5"]
    
    
    private var menu = [UIButton]()
    
    
    //MARK: IBInspectables
    
    @IBInspectable var buttonSize: CGSize = CGSize(width: 44.0, height: 40.0/*menuContainer is 40 for height : change this accordingly*/) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var nbButton: Int = 6 {
        didSet {
            setupButtons()
        }
    }
    
    
    
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    
    
    
    //MARK: Button Action
    func menuButtonTapped(button: UIButton) {
        guard let index = menu.index(of: button) else {return}
            switch index {
            case 0: displayPayInfo()
            case 1: displayPlaceInfo()
            case 2: displayTimeInfo()
            case 3: displayMetaInfos()
            case 4: forwardToContacts()
            case 5: contactClient()
            default : break 
            }
        }
        
        
        //MARK: Private Methods
        
        private func setupButtons() {
            
            // Clear any existing buttons
            for button in menu {
                removeArrangedSubview(button)
                button.removeFromSuperview()
            }
            menu.removeAll()
            
            // Load Button Images
            let bundle = Bundle(for: type(of: self))  //For the images to load properly in Interface Builder, you must explicitly specify the catalog’s bundle
            let filledStar = UIImage(named: "userPhoto", in: bundle, compatibleWith: self.traitCollection)
            let emptyStar = UIImage(named:"userPhoto", in: bundle, compatibleWith: self.traitCollection)
            let highlightedStar = UIImage(named:"userPhoto", in: bundle, compatibleWith: self.traitCollection)
            
            // Add new buttons
            for _ in 0..<nbButton {
                // Create the button
                let button = UIButton()
                
                // Set the button images
                button.setImage(emptyStar, for: .normal)
                button.setImage(filledStar, for: .selected)
                button.setImage(highlightedStar, for: .highlighted)
                button.setImage(highlightedStar, for: [.highlighted, .selected])
                
                // Add constraints
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
                button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
                
                // Setup the button action
                button.addTarget(self, action: #selector(menuButtonTapped(button:)), for: .touchUpInside)
                
                // Add the button to the stack
                addArrangedSubview(button)
                
                // Add the new button to the rating button array
                menu.append(button)
            }
        }
        
        
        
        
        
        func displayPayInfo() {
            if let context = context, let pay = needData["pay"]  {
                Alert.displayMessage(context: context, message: String(describing : pay),confirmAction : nil,completion : nil, headerTitle : "Qu'est-ce que j'y gagne ?")
            }
        }
        
        
        func displayPlaceInfo() {
            if let context = context, let place = needData["place"] {
                Alert.displayMessage(context: context, message: String(describing : place),confirmAction : nil,completion : nil, headerTitle : "Où ?")
            }
        }
        
        
        func displayTimeInfo() {
            if let context = context, let time = needData["time"] {
                Alert.displayMessage(context: context, message: String(describing : time),confirmAction : nil,completion : nil, headerTitle : "Quand ?")
            }
        }
        
        func displayMetaInfos() {
            if let context = context, let meta = needData["meta"] {
                Alert.displayMessage(context: context, message: String(describing : meta),confirmAction : nil,completion : nil, headerTitle : "Informations")
            }
        }
        
        func forwardToContacts() {
            if let context = context, let share = needData["share"] {
                context.performSegue(withIdentifier: "segueFromMarketPlaceToContactsSelection", sender: self)
            }
        }
        
        func contactClient() {
            if let context = context, let talk = needData["talk"] {
                context.performSegue(withIdentifier: "segueFromMarketPlaceToMessenger", sender: self)
            }
        }
        
        
        
}
