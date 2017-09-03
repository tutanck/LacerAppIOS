//
//  LiveShot.swift
//  LacerApp
//
//  Created by Joan Angb on 03/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import SocketIO


/**
 A a snapshot (stored data)
 
 
 
 public final func find(
 coll : String,
 query : JSONObject?=[:],
 opt : JSONObject?=[:],
 meta : JSONObject?=[:],
 ack : @escaping ([Any]) -> (),
 timeout : Double?=0
 ){
 socket.emitWithAck("find", coll, query!, opt!, meta!).timingOut(after: timeout!, callback: ack)
 }
 **/
class LiveShot : LiveStateShot {
    
    let _id : String
    let coll : String
    let tag : String?
    
    public init(
        regina : Regina,
        coll : String,
        _id : String,
        tag : String?,
        callback : @escaping ([Any], SocketAckEmitter) -> (),
        timeout : Double? = 0,
        meta : JSONObject?=[:],
        opt : JSONObject?=[:]
        ){
        
        self._id = _id
        self.coll = coll
        self.tag = tag
        
        if let tag = tag{
            regina.socket.on(tag, callback: callback)
        }
    }
    
    
    public static func queryOnDBDataChanged()->JSONObject {
        preconditionFailure("fatal : Shot's 'render()' must be overridden!")
    }
    
    public static func reinit(dataShot : JSONObject) {
        preconditionFailure("fatal : Shot's 'render()' must be overridden!")
    }
    
}


public protocol LiveStateShot{
    static func queryOnDBDataChanged()->JSONObject
    static func reinit(dataShot : JSONObject)
    
}
