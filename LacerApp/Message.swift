//
//  Message.swift
//  LacerApp
//
//  Created by Joan Angb on 23/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class Message : Shot{
    
    
    //Constants
    static let coll = DB.user_needs
    static var collTag = DB.user_needs_tag
    
    var text : String
    var author : User?
    //var date : Date
    
    init(_id : String, text : String, author : User?/*, date : Date*/){
        self.text = text
        self.author = author
        //self.date = date
        super.init(_id : _id)
    }
    
    
    init (
        snapshot : JSONObject
        ){
        
        self.text = snapshot["text"] as! String
        
        self.author = User(_id : snapshot["authorID"] as! String)
        //self.date = snapshot["_date"] as! Bool
        
        super.init(_id :  snapshot["_id"] as! String)
    }
    
    
    
    
    static func findUserInterlocutors(
        ack : @escaping ([Any]) -> ()
        ){
        
        if let userID = UserInfos._id {
            IO.r.find(
                coll: Message.coll,
                query:
                ["$or" :
                    [
                        ["authorID" : userID],
                        ["recipientID" : userID]
                    ]
                ],
                ack: ack)
        }
    }
    
    
    
    static func findPrivateConversationBetween(
        speakers : [String],
        ack : @escaping ([Any]) -> ()
        ){
        if speakers.count != 2 {
            fatalError("findPrivateConversation : private conversation has always 2 speakers!")
        }
        IO.r.find(
            coll: Message.coll,
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
