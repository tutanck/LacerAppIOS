//
//  User.swift
//  LacerApp
//
//  Created by Joan Angb on 20/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class User : Shot {
    
    //Constants
    static let coll = DB.user_profiles
    static var collTag = DB.user_profiles_tag

    let nameKey = "name"
    let statusKey = "status"
    
    let ref: DatabaseReference?

    
    var name : String
    
    var photo : UIImage?
    
    var status : Int
    
    
    init(_id : String, name : String, photo : UIImage?, status: Int){
        self.name = name
        self.status = status
        self.photo = photo
        
        ref = nil
        super.init(_id: _id)
    }
    
    init(name : String, photo : UIImage?, status: Int){
        self.name = name
        self.status = status
        self.photo = photo
        
        ref = nil
        super.init(_id: "")
    }
    
    
    override init(_id : String){
        //autoload user
        self.name = ""
        self.status = 0
        self.photo = UIImage()
        ref = nil
        super.init(_id: _id)
    }
    
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! NSDictionary

        self.name = snapshotValue[nameKey] as! String
        self.photo = UIImage(named: "userPhoto")
        self.status = snapshotValue[statusKey] as! Int
        
        ref = snapshot.ref
        super.init(_id: "")
    }

    
    
    
    static func findUserProfile(
        ack : @escaping ([Any]) -> ()
        ){
        if let userID = UserInfos._id {
            IO.r.find(
                coll: User.coll,
                query: ["_id":userID],
                ack: ack)
        }
    }
    
    
    static func findProfile(
        userID : String,
        ack : @escaping ([Any]) -> ()
        ){
        IO.r.find(
            coll: User.coll,
            query: ["_id" : userID],
            ack: ack)
    }

}
