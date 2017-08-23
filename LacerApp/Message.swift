//
//  Message.swift
//  LacerApp
//
//  Created by Joan Angb on 23/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class Message {
    
    var text : String
    var author : User?
    //var date : Date
    
    init(text : String, author : User?/*, date : Date*/){
        self.text = text
        self.author = author
        //self.date = date
    }

}
