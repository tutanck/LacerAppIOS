//
//  UserNeedSnap.swift
//  LacerApp
//
//  Created by Joan Angb on 03/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserNeedSnap : Snap {
    
    //Constants
    static let coll = DB.user_needs
    static var collTag = DB.user_needs_tag
    
    //Model properties
    var ownerID : String
    var searchText : String
    var active : Bool
    var title : String
    var description : String?
    var reward : String?
    var place : String?
    var time : String?
    
    
    init?(
        ownerID : String,
        searchText : String,
        active: Bool,
        title : String,
        description : String?="",
        reward : String?="",
        place : String?="",
        time : String?="",
        
        ack: @escaping ([Any]) -> (),
        _id : String?=nil,
        update_opt : JSONObject?=[:],
        meta : JSONObject? = ["tags":[collTag]],
        timeout : Double? = 0
        ){
        
        self.ownerID = ownerID
        self.searchText = searchText
        self.active = active
        self.title = title
        self.description = description
        self.reward = reward
        self.place = place
        self.time = time
        
        super.init(
            regina: IO.r,
            coll: UserNeedSnap.coll,
            ack: ack,
            timeout: timeout,
            _id: _id,
            meta: meta,
            update_opt : update_opt
        )
    }
    
    
    public override func render()->JSONObject {
        return [
            "ownerID" : ownerID,
            "searchText" : searchText,
            "active" : active,
            "title" : title,
            "description" : description!,
            "reward" : reward!,
            "place" : place!,
            "time" : time!
        ]
    }
    
}
