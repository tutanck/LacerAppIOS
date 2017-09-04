//
//  UserProfileSnap.swift
//  LacerApp
//
//  Created by Joan Angb on 03/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserProfileSnap : Snap {
    
    //Constants
    static let coll = DB.user_profiles
    static var collTag = DB.user_profiles_tag
    
    //Model properties
    var type : Int
    var username : String
    var resume : String
    //var photo : UIImage? //TODO
    
    
    init?(
        type: Int,
        username : String,
        resume : String,
        // photo : UIImage?,
        
        ack: @escaping ([Any]) -> (),
        _id : String?=nil,
        update_opt : JSONObject?=[:],
        meta : JSONObject? = ["tags":[collTag]],
        timeout : Double? = 0
        ){
        
        self.type = type
        self.username = username
        self.resume = resume
        //self.photo = photo
        
        super.init(
            regina: IO.r,
            coll: UserProfileSnap.coll,
            ack: ack,
            timeout: timeout,
            _id: _id,
            meta: meta,
            update_opt : update_opt
        )
    }
    
    
    public override func render()->JSONObject {
        return [
            "type" : type,
            "username" : username,
            "resume" : resume
        ]
    }
    
}
