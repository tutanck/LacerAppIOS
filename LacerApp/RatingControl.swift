//
//  RatingControl.swift
//  LacerApp
//
//  Created by Joan Angb on 05/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {
    
    
    //MARK: Properties
    
    var activated = false
    
    var starSize: CGSize = CGSize(width: 44.0, height: 44.0)
    
    var starCount: Int = 5
    
    var isEditable: Bool = false
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) { fatalError("RatingControl::init(coder: NSCoder) not implemented") }
    
    
    
    
    //MARK: Button Action
    
    func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {return}
        
        if isEditable {
            
            if let toID = self.toID {
                
                // Calculate the rating of the selected button
                var selectedRating = index + 1
                
                if index == 0 && rating == 1 { selectedRating = 0 }
                
                UserStarsSnap(toID: toID, stars: selectedRating, ack: {dataArray in print(dataArray)} )
                
            }
            
        }
    }
    
    
    var toID : String?=nil
    
    var context : UIViewController?{
        didSet{
            
            if let context = context, let userID = UserInfos._id, let toID = toID {
                
                IO.r.socket.on(UserStarsColl.tag+"/fromID:"+userID+"/toID:"+toID, callback: {
                    (dataArray, ackEmitter) in
                    let ctx = dataArray[1] as! JSONObject
                    let op = ctx["op"] as! Int
                    if op == 2 || op == -1 {
                        self.loadData()
                    }
                })
                
                loadData()
                
            }else{
                Waiter.isConfused(context!)
            }
            
        }
    }
    
    
    
    
    
    private func loadData(){
        IO.r.find(coll: UserStarsColl.name, query: ["fromID":UserInfos._id!,"toID":toID],ack: dataDidLoad)
    }
    
    
    
    private func dataDidLoad(dataArray : [Any])->(){
        Waiter.popNServ(context: context!, dataArray: dataArray, drink: {res in
            if let res = res as? JSONArray {
                populateUI(data : res)
            }
        })
    }
    
    
    
    private func populateUI(data : JSONArray){
        if self.activated == false{
            print("Debug : RatingControl activated")
            // Setup the button action
            for (index, button) in ratingButtons.enumerated() {
                button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            }
            self.activated = true
        }
        
        if data.count == 1 { self.rating = data[0]["stars"] as! Int }
        else if data.count == 0 {  rating = 0 }
        else{ Waiter.isConfused(context!) }
    }
    
    
    
    
    //MARK: Private Methods
    
    private func setupButtons() {
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))  //For the images to load properly in Interface Builder, you must explicitly specify the catalog’s bundle
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let filledStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        // Add new buttons
        for _ in 0..<starCount {
            // Create the button
            let button = UIButton()
            
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(emptyStar, for: .highlighted)
            button.setImage(emptyStar, for: [.highlighted, .selected])
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            ratingButtons.append(button)
            
            //Update the button’s selection state when buttons are added to the control
            updateButtonSelectionStates()
        }
    }
    
    
    
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
        }
    }
    
    
    
}
