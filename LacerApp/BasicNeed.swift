//
//  BasicNeed.swift
//  LacerApp
//
//  Created by Joan Angb on 16/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class BacicNeed{
    
    let titleKey = "title"
    let activKey = "activ"
    
    var title : String
    var activ : Bool
    var date : Date

    
    let ref: DatabaseReference?
    
    
    init (title : String, activ : Bool){
        self.title = title
        self.activ = activ
        self.date = Date()

        self.ref = nil
    }
    
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! NSDictionary
        title = snapshotValue[titleKey] as! String
        activ = snapshotValue[activKey] as! Bool
        
        self.date = Date()

        ref = snapshot.ref
    }
    
}
