//
//  Need.swift
//  LacerApp
//
//  Created by Joan Angb on 16/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class Need : UserNeed{
    
    let tagsKey = "tags"
    let usernameKey = "username"
    let distanceKey = "distance"
    let descriptionKey = "description"
    
    var tags : String
    var username : String
    var distance : Double
    var photo : UIImage?
    
    
    init (tags : String, username : String, distance : Double, description : String ,photo : UIImage?, title : String, activ : Bool){
        self.tags = tags
        self.username = username
        self.distance = distance
        self.photo =  UIImage(named: "userPhoto")
     
        super.init(title : title, activ : activ, description : description)
    }
    
    
    override init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! NSDictionary
    
        self.tags = snapshotValue[tagsKey] as! String
        self.username = snapshotValue[usernameKey] as! String
        self.distance = snapshotValue[distanceKey] as! Double
       // self.description = snapshotValue[descriptionKey] as! String
        self.photo =  UIImage(named: "userPhoto")
        super.init(snapshot: snapshot)
    }
    
    
}
