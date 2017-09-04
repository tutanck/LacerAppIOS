//
//  Message.swift
//  LacerApp
//
//  Created by Joan Angb on 23/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class Message : Snapshot{
    
    var text : String
    var authorID : String
    var recipientID : String
    
    
    init(_id : String,
         _date : String,
         
         text : String,
         authorID : String,
         recipientID : String
        ){
        
        self.text = text
        self.authorID = authorID
        self.recipientID = recipientID
        
        super.init(_id : _id,
                   _date: _date)
    }
    
    
    init (
        snapshot : JSONObject
        ){
        
        self.text = snapshot["text"] as! String
        self.authorID = snapshot["authorID"] as! String
        self.recipientID = snapshot["recipientID"] as! String
        
        super.init(_id :  snapshot["_id"] as! String,
                   _date: snapshot["_date"] as! String)
    }
    
    
}
