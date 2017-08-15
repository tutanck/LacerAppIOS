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
    var activ : Bool
    let ref: DatabaseReference?
    
    init(snapshot: DataSnapshot) {
        title = snapshot.key
        activ = snapshot.value as! Bool
        ref = snapshot.ref
    }
    
}
