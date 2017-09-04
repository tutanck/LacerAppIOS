//
//  UserStatusSnap.swift
//  LacerApp
//
//  Created by Joan Angb on 04/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class UserStatusSnap : Snap {
    
    var status : Int
    
    
    init?(
        status: Int,
        
        ack: (([Any]) -> ())? = {dataArray in},
        _id : String? = UserInfos._id!,
        update_opt : JSONObject?=["upsert":true],
        meta : JSONObject? =
        ["tags":
            [
                ["kind" : "io",
                 "val" : UserStatusColl.tag+"/"+UserInfos._id!]
            ]
        ],
        timeout : Double? = 0
        ){
        
        self.status = status
        
        super.init(
            regina: IO.r,
            coll: UserStatusColl.coll,
            ack: ack!,
            timeout: timeout,
            _id: _id,
            meta: meta,
            update_opt : update_opt
        )
    }
    
    
    public override func render()->JSONObject {
        return [
            "status" : status
            //,"position" : position
        ]
    }
    
}
