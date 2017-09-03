//
//  UserNeed.swift
//  LacerApp
//
//  Created by Joan Angb on 16/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class UserNeed {
    
    //Constants
    static let regina = IO.r
    static let coll = DB.user_needs
    static var collTag = DB.user_needs_tag
    
    var _id : String
    var title : String
    var description : String
    var visible : Bool
    var date : Date
    
    
    init (_id : String, title : String, visible : Bool, description : String){
        self._id = _id
        self.title = title
        self.visible = visible
        self.description = description
        self.date = Date()
        
        self.ref = nil
    }
    
    init (snapshot : JSONObject){
        self._id = snapshot["_id"] as! String
        self.title = snapshot["title"] as! String
        self.description = snapshot["description"] as! String
        self.visible = snapshot["visible"] as! Bool
        
        self.date = Date()
        
        ref = nil
    }
    
    
    static func find(ack : @escaping ([Any]) -> ()){
        if let userID = UserInfos._id {
            regina.find(
                coll: UserNeed.coll,
                query: ["ownerID":userID],
                opt: [
                    "title": 1,
                    "description": 1,
                    "visible": 1
                ],
                ack: ack)
        }
    }
    
    
    
    let ref: DatabaseReference?
    let titleKey = "title"
    let activKey = "activ"
    init(snapshot: DataSnapshot) {
        self._id = ""
        self.description = ""
        let snapshotValue = snapshot.value as! NSDictionary
        title = snapshotValue[titleKey] as! String
        visible = snapshotValue[activKey] as! Bool
        
        self.date = Date()
        
        ref = snapshot.ref
    }
    
}
