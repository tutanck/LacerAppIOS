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
    
    var context : UIViewController?{
        didSet {
            if context != nil{
                setupSwitchButton()
            }
        }
    }
    
    /*//MARK: Firef
     
     var ref : DatabaseReference? = nil{
     didSet {
     setupSwitchButton()
     }
     }*/
    
    
    
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
        /*  if let ref = self.ref{
         ref.removeAllObservers()
         }*/
    }
    
    
    //MARK: Button Action
    func switchColor(button: UIButton) {         //REMINDER : blue : imediatelly available
        
        let nextColor : UIColor = intToColor[(colorToInt[backgroundColor!]!+1)%intToColor.count]!
        
        //if context != nil /*&& ref != nil */{
        Alert.displayMessage(context: context!,
                             headerTitle :"Attention!",
                             message: messages[nextColor]!,
                             confirmAction : { action in
                                UserStatusSnap(status: self.colorToInt[nextColor]!)
                                print ("confirmed")
                                // action in self.ref?.setValue(self.colorToInt[nextColor])
                                
        },
                             cancellable : true)
        // }
    }
    
    
    
    //MARK: Private Methods
    
    /*private func setupSwitchButton() {
     
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
     }*/
    
    
    private func setupSwitchButton() {
        if let userID = UserInfos._id {
            IO.r.socket.on(DB.user_status_tag+"/"+userID, callback: { (dataArray) in /*check itsan update*/self.loadData() })
            loadData()
        }
    }
    
    
    private func loadData(){
        if let userID = UserInfos._id {
            IO.r.find(coll: DB.user_status, query: ["_id":userID], ack: dataDidLoad)
        }
    }
    
    private func dataDidLoad(dataArray : [Any])->(){
        Waiter.popNServ(context: context!, dataArray: dataArray, drink: {res in
            if let res = res as? JSONObjects {
                populateUI(data : res)
            }
        })
    }
    
    private func populateUI(data : JSONObjects){
        
        if UserInfos._id == nil { return }
        
        if data.count == 1 {
            let userStatus = data[0]
            self.backgroundColor = self.intToColor[userStatus["status"] as? Int ?? 1 ]
            
            if self.activated == false{
                print("Debug : SwitchableColorButton activated")
                // Setup the button action
                self.addTarget(self, action: #selector(SwitchableColorButton.switchColor(button:)), for: .touchUpInside)
                self.activated = true
            }

        }else if data.count == 0 {
            UserStatusSnap(status: 1)
        }else{
            Waiter.isConfused(context!)
        }
    }

}
