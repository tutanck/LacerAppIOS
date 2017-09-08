//
//  UserStarsColl.swift
//  LacerApp
//
//  Created by Joan Angb on 08/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserStarsColl {
    
    static let name = "user_stars"
    static let tag = "#"+name
    
    static func findReputation(
        ofID : String,
        ack : @escaping ([Any]) -> ()
        ){
        IO.r.aggregate(
            coll: name,
            pipeline: [
                ["$match":
                    ["toID":ofID]
                ]
                ,["$group":
                    [
                        "_id" : "$toID"
                        , "nbStars" : ["$sum": "$stars" ]
                        ,"nbVoters": [ "$sum": 1 ]
                    ]
                ],
                 ["$project": [
                    "nbStars": 1,
                    "nbVoters": 1,
                    "reputation": ["$divide": ["$nbStars", "$nbVoters"] ]
                    ]
                ]
            ],
            ack: ack)
    }
    
    
}
