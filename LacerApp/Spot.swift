//
//  Spot.swift
//  LacerApp
//
//  Created by Joan Angb on 09/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class Spot : UIImageView {
    
    
    var userID : String?=nil{
        didSet{
            if let userID = userID {
                listen(to : userID)
            }
        }
    }
    
    private func listen(to : String){
        IO.r.socket.on(UserStatusColl.tag+"/"+userID!, callback: {
            (dataArray, ackEmitter) in
            
            let ctx = dataArray[1] as! JSONObject
            if ctx["op"] as! Int == 2 {
                self.loadData()
            }
            
        })
        loadData()
    }
    
    
    private func loadData(){
        IO.r.find(coll: UserStatusColl.name, query: ["_id":userID!], ack: dataDidLoad)
    }
    
    private func dataDidLoad(dataArray : [Any])->(){
        Waiter.popNServ(dataArray: dataArray, drink: {res in
            if let data = res as? JSONArray {
                
                if data.count == 1 {
                    self.backgroundColor = SwitchableColorButton.intToColor[data[0]["status"] as! Int]
                }else{ backgroundColor = .blue/*.clear*/ }
            
            }
        })
    }
    
    
}
