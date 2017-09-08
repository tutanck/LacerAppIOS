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
    
    
    static func findUserConversation(
        with utherID : String,
        ack : @escaping ([Any]) -> ()
        ){
        if let userID = UserInfos._id {
            IO.r.find(
                coll: name,
                query:
                ["$or" :
                    [
                        
                        [ "$and" :
                            [
                                ["authorID" : userID]
                                ,["recipientID" : utherID]
                            ]
                        ],
                        
                        [ "$and" :
                            [
                                ["authorID" : utherID]
                                ,["recipientID" : userID]
                            ]
                        ]
                        
                    ]
                ],
                ack: ack)
        }
    }
    
    
    
    
    static func findUserIntelocutors(
        ack : @escaping ([Any]) -> ()
        ){
        
        if let userID = UserInfos._id {
            
            //TODO
        }
        
    }
    
}
