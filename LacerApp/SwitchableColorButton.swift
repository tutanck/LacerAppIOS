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
    
    //MARK: Hard coded Properties
    
    private let messages : [UIColor:String] = [
        .red : "Invisible : Vous ne serez plus visible. Vous ne recevrez pas de notifications.",
        .green : "Disponible : Vous serez visible et prioritaire. Vous recevrez des notifications sonores.",
        .orange : "Occupé : Vous serez toujours visible mais pas prioritaire. Vous recevrez des notifications silencieuses."
    ]
    
    static let colorToInt : [UIColor:Int] = [
        .red : 0,
        .green : 1,
        .orange : 2
    ]
    
    static let intToColor : [Int:UIColor] = [
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
        //TODO wakanai what
    }
    
    
    //MARK: Button Action
    func switchColor(button: UIButton) {         //REMINDER : blue : imediatelly available
        
        let nextColor : UIColor = SwitchableColorButton.intToColor[
            (SwitchableColorButton.colorToInt[backgroundColor!]!+1)%SwitchableColorButton.intToColor.count
            ]!
        Alert.displayMessage(context: context!,
                             headerTitle :"Attention!",
                             message: messages[nextColor]!,
                             confirmAction : { _ in
                                UserStatusSnap(
                                    status: SwitchableColorButton.colorToInt[nextColor]!,
                                    ack: { dataArray in print("Snap : \(dataArray)")}
                                ) },
                             cancellable : true)
    }
    
    
    
    //MARK: Private Methods
    
    private func setupSwitchButton() {
        if let userID = UserInfos._id {
            IO.r.socket.on(UserStatusColl.tag+"/"+userID, callback: {
                (dataArray, ackEmitter) in
                
                let ctx = dataArray[1] as! JSONObject
                if ctx["op"] as! Int == 2 {
                    self.loadData()
                }
                
            })
            loadData()
        }
    }
    
    
    private func loadData(){
        if let userID = UserInfos._id {
            IO.r.find(coll: UserStatusColl.name, query: ["_id":userID], ack: dataDidLoad)
        }
    }
    
    private func dataDidLoad(dataArray : [Any])->(){
        Waiter.popNServ(context: context!, dataArray: dataArray, drink: {res in
            if let res = res as? JSONArray {
                populateUI(data : res)
            }
        })
    }
    
    private func populateUI(data : JSONArray){
        
        if UserInfos._id == nil { return }
        
        if data.count == 1 {
             self.backgroundColor = SwitchableColorButton.intToColor[data[0]["status"] as! Int]
            
            if self.activated == false{
                print("Debug : SwitchableColorButton activated")
                // Setup the button action
                self.addTarget(self, action: #selector(SwitchableColorButton.switchColor(button:)), for: .touchUpInside)
                self.activated = true
            }
            
        }
        else if data.count == 0 { UserStatusSnap(
            status: 1,
            ack: { dataArray in print("Snap : \(dataArray)")}
            ) }
        else{ Waiter.isConfused(context!) }
    }
    
}
