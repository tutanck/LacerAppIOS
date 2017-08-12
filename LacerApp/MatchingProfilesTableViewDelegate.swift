//
//  MatchingProfilesTableViewDelegate.swift
//  LacerApp
//
//  Created by Joan Angb on 12/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class MatchingProfilesTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - private methods
    
    var tableView : UITableView?
    
    
    var filteredProfiles = [User]()
    
    
    let matchingProfiles : [User] = [
        User(name: "Angb joan", photo:UIImage(named: "userPhoto"), status: 1),
        User(name: "Diogo Justino", photo: UIImage(named: "userPhoto"), status: 0),
        User(name: "Tesla", photo: UIImage(named: "userPhoto"), status: 2)
    ]
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchingProfiles.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchingProfileTableViewCell") as! MatchingProfileTableViewCell
        
        // set the text from the data model
        cell.photoImageView.image = self.matchingProfiles[indexPath.row].photo
        cell.usernameLabel.text = self.matchingProfiles[indexPath.row].name
        cell.userstatusSpot.backgroundColor = StatusColor.getColor(status : self.matchingProfiles[indexPath.row].status)
        
        return cell
    }
    
    //MARK: Search Logic
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Tout") {
        filteredProfiles = matchingProfiles.filter { contact in
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
