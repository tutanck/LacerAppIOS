//
//  UserProfile.swift
//  LacerApp
//
//  Created by Joan Angb on 03/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserProfile : Snap {
    
    //Constants
    static let regina = IO.r
    static let coll = "profiles"
    
    //Configurables
    static var timeout : Double? = 0
    static var meta : JSONObject? = ["tags":["#"+coll]]
    
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
        _id : String?=nil
        ){
        self.type = type
        self.username = username
        self.resume = resume
        //self.photo = photo
        
        super.init(
            regina: UserProfile.regina,
            coll: UserProfile.coll,
            ack: ack,
            timeout: UserProfile.timeout,
            _id: _id,
            meta: UserProfile.meta)
    }
    
}
