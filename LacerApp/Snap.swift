//
//  Snap.swift
//  LacerApp
//
//  Created by Joan Angb on 02/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import SocketIO


/**
 Not a snapshot (stored) but actually a snap like a snapchat's snap (ephemerial or death born)
 **/
class Snap : Stateshot {
    
    public init?(
        regina : Regina,
        coll : String,
        ack : @escaping ([Any]) -> (),
        timeout : Double? = 0,
        _id : String?=nil,
        meta : JSONObject?=[:],
        insert_opt : JSONObject?=[:],
        update_opt : JSONObject?=[:]
        ) {
        
        if let _id = _id {
            regina.update(
                coll: coll,
                query: ["_id" : _id],
                update: render(),
                opt: update_opt,
                meta: meta,
                ack: ack,
                timeout: timeout)
        }else{
            regina.insert(
                coll: coll,
                doc: render(),
                opt: insert_opt,
                meta: meta,
                ack: ack,
                timeout: timeout)
        }
        
        return nil //transient init
    }
    
    
    public func render()->JSONObject {
        preconditionFailure("Snap's property 'rendering' must be set! Override the render() method for this purpose.")
    }
    
    final func socketRepresentation() -> SocketData { return render() }
    
}


public protocol Stateshot : SocketData{ func render()->JSONObject }
