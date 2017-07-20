//
//  File.swift
//  LacerApp
//
//  Created by Joan Angb on 20/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class StatusColor {
    
    
    static func getColor(status : Int) -> UIColor {
        switch status {
            
        case 0 :
            return UIColor.red
        case 1 :
            return UIColor.green
        case 2 :
            return UIColor.orange
        case 3 :
            return UIColor.blue
            
        default:
            return UIColor.green
        }
        
    }
    
    
}
