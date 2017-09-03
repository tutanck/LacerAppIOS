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
    
    public final let socket : SocketIOClient
    
    public init(
        serverURL : String,
        delegate : SocketClientEventDelegate
        ) {
        
        //linked server config
        if let url = URL(string: serverURL){
            socket = SocketIOClient(socketURL: url, config: [.log(false), .compress]) //config : log socket messages and allow data compression
        }else{
            fatalError("Regina client failed to init due to failure of the initialization of the server's url")
        }
        
        
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
    public final func connect() {socket.connect()}
    
    public final func disconnect() {socket.disconnect()}
    
    
    
    
    //regina's services (convenience methods)
    
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
    
    
    
    public final func count(
        coll : String,
        query : JSONObject?=[:],
        opt : JSONObject?=[:],
        meta : JSONObject?=[:],
        ack : @escaping ([Any]) -> (),
        timeout : Double?=0
        ){
        socket.emitWithAck("count", coll, query!, opt!, meta!).timingOut(after: timeout!, callback: ack)
    }
    
    
    
    public final func insert(
        coll : String,
        docs : JSONObjects,
        opt : JSONObject?=[:],
        meta : JSONObject?=[:],
        ack : @escaping ([Any]) -> (),
        timeout : Double?=0
        ){
        socket.emitWithAck("insert", coll, docs, opt!, meta!).timingOut(after: timeout!, callback: ack)
    }
    
    
    public final func insert(
        coll : String,
        doc : JSONObject,
        opt : JSONObject?=[:],
        meta : JSONObject?=[:],
        ack : @escaping ([Any]) -> (),
        timeout : Double?=0
        ){
        socket.emitWithAck("insert", coll, doc, opt!, meta!).timingOut(after: timeout!, callback: ack)
    }
    
    
    
    public final func update(
        coll : String,
        query : JSONObject,
        update : JSONObject,
        opt : JSONObject?=[:],
        meta : JSONObject?=[:],
        ack : @escaping ([Any]) -> (),
        timeout : Double?=0
        ){
        socket.emitWithAck("update", coll, query, update, opt!, meta!).timingOut(after: timeout!, callback: ack)
    }
    
    
    
    public final func remove(
        coll : String,
        query : JSONObject,
        opt : JSONObject?=[:],
        meta : JSONObject?=[:],
        ack : @escaping ([Any]) -> (),
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
    case noack = "regina_noack_callback_error"
}

public typealias JSONObject = [String: Any]
public typealias JSONObjects = [[String: Any]]
