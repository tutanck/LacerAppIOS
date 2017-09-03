//
//  Shot.swift
//  LacerApp
//
//  Created by Joan Angb on 03/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class Shot : StateShot {
    
    var _id : String
    
    init(
        _id : String
        ){
        self._id = _id
    }
}


public protocol StateShot {}
