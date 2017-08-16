//
//  Fire.swift
//  LacerApp
//
//  Created by Joan Angb on 15/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class Fire{
    
    //MARK : static refs
    
    static let rootRef = Database.database().reference()
    
    static let usersRef = rootRef.child("users")

    static let needsRef = rootRef.child("needs")
    
    static let keywordsRef = rootRef.child("keywords")

    
    //MARK : static ref keys
    
    static let userStatusKey = "status"
    
    static let userProfileKey = "profile"

    static let userTypeKey = "type"
    static let userNameKey = "username"
    static let userDescriptionKey = "description"
    
    static let userKeywordsKey = "keywords"
    
    static let userNeedTitleKey = "title"
    static let userNeedDescriptionKey = "description"
    static let userNeedIsActivKey = "activ"

    static let userNeedsKey = "needs"
}
