//
//  MatchingProfilesTableViewDelegate.swift
//  LacerApp
//
//  Created by Joan Angb on 12/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class MatchingProfilesTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    
    let cellID = "MatchingProfilesTableViewCell"
    
    
    var tableView : UITableView?
    
    
    var filteredProfiles = [User]()
    
    var profiles : [User] = [
        User(name : "Joan", photo : UIImage(named : "userPhoto"), status: 1),
        User(name : "Joan", photo : UIImage(named : "userPhoto"), status: 1),
        User(name : "Joan", photo : UIImage(named : "userPhoto"), status: 1),
        User(name : "Joan", photo : UIImage(named : "userPhoto"), status: 1),
        User(name : "Joan", photo : UIImage(named : "userPhoto"), status: 1)
    ]
    
    
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 84;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profiles.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MatchingProfilesTableViewCell  else {
            fatalError("The dequeued cell is not an instance of " + cellID)
        }
        
        let profile = profiles[indexPath.row]
        
        cell.nameLabel.text = profile.name
        cell.messageLabel.text = "TODO"
        cell.profileImageView.image = profile.photo
        //cell.userstatusLabel.backgroundColor = StatusColor.getColor(status : contact.status)
        
        return cell
    }
    
    //MARK: Search Logic
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Tout") {
        filteredProfiles = profiles.filter { contact in
            let categoryMatch = (scope == "Tout") //|| (user.category == scope)
            return  categoryMatch && contact.name.lowercased().contains(searchText.lowercased())
        }
        if tableView != nil {
            tableView!.reloadData()
        }else{
            fatalError("MatchingProfilesTableViewDelegate : tableView is not loaded")
        }
    }
    
}

//SearchDelegate
extension MatchingProfilesTableViewDelegate : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

//SearchBar's Scope Bar delegate
extension MatchingProfilesTableViewDelegate: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
