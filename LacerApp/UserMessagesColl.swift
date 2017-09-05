//
//  UserMessagesColl.swift
//  LacerApp
//
//  Created by Joan Angb on 04/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserMessagesColl {
    
    static let name = "user_messages"
    static let tag = "#"+name
    
    
    static func findPrivateConversationBetween(
        speakers : [String],
        ack : @escaping ([Any]) -> ()
        ){
        if speakers.count != 2 {
            fatalError("findPrivateConversation : private conversation has always 2 speakers!")
        }
        IO.r.find(
            coll: name,
            query:
            ["$or" :
                [
                    
                    [ "$and" :
                        [
                            ["authorID" : speakers[0]]
                            ,["recipientID" : speakers[1]]
                        ]
                    ],
                    
                    [ "$and" :
                        [
                            ["authorID" : speakers[1]]
                            ,["recipientID" : speakers[0]]
                        ]
                    ]
                    
                ]
            ],
            ack: ack)
    }

}
