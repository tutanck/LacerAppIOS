//
//  DatesManager.swift
//  LacerApp
//
//  Created by Joan Angb on 04/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class DatesManager {
    
    static func toDate(_ dateStr: String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        return dateFormatter.date(from: dateStr)
    }
   
}
