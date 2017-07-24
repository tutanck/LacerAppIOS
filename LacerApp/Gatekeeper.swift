//
//  Gatekeeper.swift
//  LacerApp
//
//  Created by Joan Angb on 24/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class Gatekeeper {
    
    
    static func getGate() -> UIViewController? {
        
        return  UIStoryboard(name : "Lace", bundle: nil).instantiateInitialViewController() as UIViewController?
    
    }
}
