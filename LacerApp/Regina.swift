//
//  Regina.swift
//  LacerApp
//
//  Created by Joan Angb on 31/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import SocketIO

public class Regina {
    
    public let socket : SocketIOClient
    
    public init?(
        serverURL : String,
        delegate : SocketClientEventDelegate
        ) {
        
        //linked server config
        if let url = URL(string: serverURL){
            socket = SocketIOClient(socketURL: url, config: [.log(true), .compress]) //TODO CHECK OPTIONS MEANING
        }else{ return nil }
        
        
        //Events handling
        
        socket.on(clientEvent : .connect) { dataArray, ack in
            delegate.handle(clientEvent: .connect)
        }
        
        socket.on(clientEvent : .disconnect) { dataArray, ack in
            delegate.handle(clientEvent: .disconnect)
        }
        
        socket.on(clientEvent : .error) { dataArray, ack in
            delegate.handle(clientEvent: .error)
        }
        
        socket.on(clientEvent : .reconnect) { dataArray, ack in
            delegate.handle(clientEvent: .reconnect)
        }
        
        socket.on(clientEvent : .reconnectAttempt) { dataArray, ack in
            delegate.handle(clientEvent: .reconnectAttempt)
        }
        
        socket.on(clientEvent : .statusChange) { dataArray, ack in
            delegate.handle(clientEvent: .statusChange)
        }
        
        //regina_warning
        
        socket.on(ReginaEvent.noack.rawValue) { dataArray, ack in
            delegate.handle(reginaEvent: .noack, message : dataArray[0] as! String) //TODO TEST
        }

    }
    
    deinit {
        //TODO LATE LATER (in case of dynamic multi-server clean this useless server only : probably disconnect)
    }
    
    
    
    //SocketIO io commubication convenience methods
    public func connect() {socket.connect()}
    
    public func disconnect() {socket.disconnect()}
    
    
    
    
    //regina's services (convenience methods)
    
    public func find(
        coll : String,
        query : SocketData?=[:],
        opt : SocketData?=[:],
        meta : NSDictionary?=[:],
        ack : @escaping AckCallback,
        timeout : Double?=0
        ){
        socket.emitWithAck("find", coll, query!, opt!, meta!).timingOut(after: timeout!, callback: ack)
    }
    
    
    
    public func count(
        coll : String,
        query : SocketData?=[:],
        opt : SocketData?=[:],
        meta : NSDictionary?=[:],
        ack : @escaping AckCallback,
        timeout : Double?=0
        ){
        socket.emitWithAck("count", coll, query!, opt!, meta!).timingOut(after: timeout!, callback: ack)
    }
    
    
    
    public func insert(
        coll : String,
        docs : SocketData,
        opt : SocketData?=[:],
        meta : NSDictionary?=[:],
        ack : @escaping AckCallback,
        timeout : Double?=0
        ){
        socket.emitWithAck("insert", coll, docs, opt!, meta!).timingOut(after: timeout!, callback: ack)
    }
    
    
    
    public func update(
        coll : String,
        query : SocketData,
        update : SocketData,
        opt : SocketData?=[:],
        meta : NSDictionary?=[:],
        ack : @escaping AckCallback,
        timeout : Double?=0
        ){
        socket.emitWithAck("update", coll, query, update, opt!, meta!).timingOut(after: timeout!, callback: ack)
    }
    
    
    
    public func remove(
        coll : String,
        query : SocketData,
        opt : SocketData?=[:],
        meta : NSDictionary?=[:],
        ack : @escaping AckCallback,
        timeout : Double?=0
        ){
        socket.emitWithAck("remove", coll, query, opt!, meta!).timingOut(after: timeout!, callback: ack)
    }
    
    //TODO SocketAckStatus management on timeout passed
}


public protocol SocketClientEventDelegate {
    func handle(clientEvent : SocketClientEvent)
    func handle(reginaEvent : ReginaEvent, message : String)
}

public enum ReginaEvent : String {
    case noack = "regina_noack"
}


