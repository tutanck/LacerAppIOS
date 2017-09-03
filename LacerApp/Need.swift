//
//  Need.swift
//  LacerApp
//
//  Created by Joan Angb on 16/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class Need : UserNeedShot{
    
    let tagsKey = "tags"
    let usernameKey = "username"
    let distanceKey = "distance"
    let descriptionKey = "description"
    
    var tags : String
    var username : String
    var distance : Double
    var photo : UIImage?
    
    
    init (_id : String, tags : String, username : String, distance : Double, description : String ,photo : UIImage?, title : String, visible : Bool){
        self.tags = tags
        self.username = username
        self.distance = distance
        self.photo =  UIImage(named: "userPhoto")
     
        super.init(_id : _id, title : title, visible : visible, description : description)
    }
    
    
     init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! NSDictionary
    
        self.tags = snapshotValue[tagsKey] as! String
        self.username = snapshotValue[usernameKey] as! String
        self.distance = snapshotValue[distanceKey] as! Double
       // self.description = snapshotValue[descriptionKey] as! String
        self.photo =  UIImage(named: "userPhoto")
        //super.init(snapshot: snapshot)
        
        super.init(_id : "", title : "", visible : false, description : "")
    }
    
    
}
