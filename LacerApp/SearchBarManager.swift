//
//  SearchBarManager.swift
//  LacerApp
//
//  Created by Joan Angb on 07/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class SearchBarManager{
    
    // Returns true if the text is empty or nil
    static func isEmpty(
        _ searchBarSearchController : UISearchController
        ) -> Bool {
        return searchBarSearchController.searchBar.text?.isEmpty ?? true
    }
    
    
    static func isFiltering(
        _ searchBarSearchController : UISearchController
        ) -> Bool {
        
        let isScopeFiltering = searchBarSearchController.searchBar.selectedScopeButtonIndex != 0
        let searchBarIsEmpty = SearchBarManager.isEmpty(searchBarSearchController)
        
        return searchBarSearchController.isActive && (!searchBarIsEmpty || isScopeFiltering)
    }
}
