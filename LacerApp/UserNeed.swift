//
//  UserNeed.swift
//  LacerApp
//
//  Created by Joan Angb on 16/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class UserNeed{
    
    var title : String
    var description : String
    var activ : Bool
    var date : Date
    
    
    init (title : String, activ : Bool, description : String){
        self.title = title
        self.description = description

        self.activ = activ
        self.date = Date()
        
        self.ref = nil
    }
    
    init (dataShot : JSONObject){
        self.title = dataShot["title"] as! String
        self.description = dataShot["description"] as! String
        self.activ = dataShot["activ"] as! Bool
        
        self.date = Date()
        
        ref = nil
    }
    
    
    
    let ref: DatabaseReference?
    let titleKey = "title"
    let activKey = "activ"
    init(snapshot: DataSnapshot) {
        self.description = ""
        let snapshotValue = snapshot.value as! NSDictionary
        title = snapshotValue[titleKey] as! String
        activ = snapshotValue[activKey] as! Bool
        
        self.date = Date()
        
        ref = snapshot.ref
    }
    
}
