//
//  UserKeywordSnap.swift
//  LacerApp
//
//  Created by Joan Angb on 05/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class UserKeywordSnap : Snap {

    static let meta = ["tags":
        [
            ["kind" : "io",
             "val" : UserKeywordsColl.tag+"/"+UserInfos._id!],
            ["kind" : "io",
             "val" : UserKeywordsColl.tag]
        ]
    ]
    
    
    var title : String
    var active : Bool
    
    
    init?(
        title : String,
        active: Bool?=true,
        
        ack: @escaping ([Any]) -> (),
        meta : JSONObject? = meta,
        timeout : Double? = 0
        ){
        
        let title = title.lowercased() //important!
        self.title = title
        self.active = active!
        
        super.init(
            regina: IO.r,
            coll: UserKeywordsColl.name,
            ack: ack,
            timeout: timeout,
            query: ["ownerID":UserInfos._id!, "title":title],
            meta: meta,
            opt : ["upsert":true]
        )
    }
    
    
    
    init?(
        _id : String,
        title: String,
        active: Bool?=true,
        
        ack: @escaping ([Any]) -> (),
        meta : JSONObject? = meta,
        timeout : Double? = 0
        ){
        
        let title = title.lowercased() //important!
        self.title = title
        self.active = active!
        
        super.init(
            regina: IO.r,
            coll: UserKeywordsColl.name,
            ack: ack,
            timeout: timeout,
            _id: _id,
            meta: meta
        )
    }
    

    
    
    
    public override func render()->JSONObject {
        return [
            "title" : title
            ,"active" : active
            ,"ownerID" : UserInfos._id!
        ]
    }
    
    
}
