//
//  Service.swift
//  LacerApp
//
//  Created by Joan Angb on 19/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class Service {
    
    var title : String
    var activ : Bool
    
    var make : Bool
    var teach : Bool
    var advise : Bool
    
    var skills : [Skill] = []
    
    init(title : String,activ : Bool, make : Bool, teach : Bool, advise: Bool, skills: [Skill]) {
        self.title = title
        self.activ = activ
        
        self.make = make
        self.teach = teach
        self.advise = advise

        self.skills = skills

    }
    
    
}
