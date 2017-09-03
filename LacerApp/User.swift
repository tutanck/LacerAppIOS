//
//  User.swift
//  LacerApp
//
//  Created by Joan Angb on 20/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class User {
    //Constants
    static let regina = IO.r
    static let coll = DB.user_profiles
    static var collTag = DB.user_profiles_tag

    let nameKey = "name"
    let statusKey = "status"
    
    let ref: DatabaseReference?

    
    var name : String
    
    var photo : UIImage?
    
    var status : Int
    
    
    init(name : String, photo : UIImage?, status: Int){
        self.name = name
        self.status = status
        self.photo = photo
        
        ref = nil
    }
    
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! NSDictionary

        self.name = snapshotValue[nameKey] as! String
        self.photo = UIImage(named: "userPhoto")
        self.status = snapshotValue[statusKey] as! Int
        
        ref = snapshot.ref
    }

    
    
    
    static func findUserProfile(
        ack : @escaping ([Any]) -> ()
        ){
        if let userID = UserInfos._id {
            regina.find(
                coll: User.coll,
                query: ["_id":userID],
                ack: ack)
        }
    }
    
    
    static func findProfile(
        userID : String,
        ack : @escaping ([Any]) -> ()
        ){
        regina.find(
            coll: User.coll,
            query: ["_id" : userID],
            ack: ack)
    }

}
