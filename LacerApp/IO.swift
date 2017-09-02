//
//  IO.swift
//  LacerApp
//
//  Created by Joan Angb on 02/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import SocketIO


class IO : NSObject, SocketClientEventDelegate{
    
    static let io = IO()
    
    static var r = Regina(
        serverURL : "http://192.168.1.15:3009",
        delegate : io
    )
    
    
    
    func handle(clientEvent: SocketClientEvent) {
        print("clientEvent : \(clientEvent)")
    }
    
    
    func handle(reginaEvent: ReginaEvent, message: String) {
         print("reginaEvent : \(reginaEvent) : \(message)")
    }
    
}
