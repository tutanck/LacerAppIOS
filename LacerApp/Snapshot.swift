//
//  Shot.swift
//  LacerApp
//
//  Created by Joan Angb on 03/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class Snapshot : StateShot {
    
    var _id : String
    var _date : Date
    
    init(
        _id : String,
        _date : String
        ){
        self._id = _id
        self._date = Snapshot.toDate(_date)!
    }
    
    static func toDate(_ dateStr: String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        return dateFormatter.date(from: dateStr)
    }
}


public protocol StateShot {}
