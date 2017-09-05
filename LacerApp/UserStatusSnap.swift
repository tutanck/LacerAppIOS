//
//  UserStatusSnap.swift
//  LacerApp
//
//  Created by Joan Angb on 04/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class UserStatusSnap : Snap {
    
    static let meta = ["tags":
        [
            ["kind" : "io",
             "val" : UserStatusColl.tag+"/"+UserInfos._id!]
        ]
    ]
    
    
    var status : Int
    
    
    init?(
        status: Int,
        
        ack: @escaping ([Any]) -> (),
        meta : JSONObject? = meta,
        timeout : Double? = 0
        ){
        
        self.status = status
        
        super.init(
            regina: IO.r,
            coll: UserStatusColl.name,
            ack: ack,
            timeout: timeout,
            _id: UserInfos._id!,
            meta: meta,
            update_opt : ["upsert":true]
        )
    }
    
    
    public override func render()->JSONObject {
        return [
            "status" : status
            //,"position" : position
        ]
    }
    
}
