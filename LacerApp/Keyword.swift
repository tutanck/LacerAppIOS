//
//  Keyword.swift
//  LacerApp
//
//  Created by Joan Angb on 19/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//


import UIKit
import Firebase

class Keyword {
    
    var title : String
    var active : Bool
    let ref: DatabaseReference?
    
    init (title : String, active : Bool){
        self.title = title
        self.active = active
        
        ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        title = snapshot.key
        active = snapshot.value as! Bool
        ref = snapshot.ref
    }
    
}
