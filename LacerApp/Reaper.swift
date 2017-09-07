//
//  Reaper.swift
//  LacerApp
//
//  Created by Joan Angb on 07/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class Reaper {
    
    static func delete (
        coll : String,
        _id : String,
        meta : JSONObject? = JSONObject(),
        ack : @escaping ([Any]) -> ()
        ){
        if let userID = UserInfos._id {
            IO.r.update(coll: coll, query: ["_id":_id], update: ["$set" : ["deleted" : true]], meta: meta, ack: ack)
        }
    }
    
}
