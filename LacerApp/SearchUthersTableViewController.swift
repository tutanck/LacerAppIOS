//
//  SearchUthersTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 20/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class SearchUthersTableViewController: UITableViewController {
    
    
    let cellID = "SearchUthersTableViewCell"
    
    
    // MARK: - Properties
    
    var users : [User] = [User(_id : "", username : "Joan", status: 1)]

    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    
    // MARK: - System events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SearchController parameters
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        //SearchController's search bar parameters
        searchController.searchBar.scopeButtonTitles = ["Particuliers","Entreprises"]
        searchController.searchBar.delegate = self
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? SearchUthersTableViewCell  else {
            fatalError("The dequeued cell is not an instance of " + cellID)
        }
        
        let user = users[indexPath.row]
        
        cell.nameLabel.text = user.username
        cell.messageLabel.text = "TODO"
        cell.profileImageView.image = user.photo
        //cell.userstatusLabel.backgroundColor = StatusColor.getColor(status : contact.status)
        
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //model 4 later
        /* if segue.identifier == "segueFromSearchUthersToUtherProfil" {
         if let indexPath = tableView.indexPathForSelectedRow {
         
         let user : User
         
         if (searchController.isActive && searchController.searchBar.text != "") {
         user = filteredUsers[indexPath.row]
         } else {
         user = users[indexPath.row]
         }
         }
         }
         
         guard let utherProfileController = segue.destination as? UtherProfileTableViewController else {
         fatalError("The segue.destination is not an instance of UtherProfileTableViewController.")
         }
         
         utherProfileController.user = user*/
        
    }
    
    
    //MARK: Search Logic
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
       /*             let categoryMatch = (scope == "All") //|| (user.category == scope)
            return  categoryMatch && user.name.lowercased().contains(searchText.lowercased())
        */
        
        if searchController.isActive && searchController.searchBar.text != "" {
           /* Fire.usersRef.queryOrdered(byChild:"profile/username" ).queryStarting(atValue: searchText).observe(.value, with: { snapshot in
                var tmp : [User] = []
                print(snapshot.value)
                /*for item in snapshot.children {
                 tmp.append(User(snapshot: item as! DataSnapshot))
                 }
                 
                 self.users = tmp*/
                self.tableView.reloadData()
            })
        */
        }
        
        

    }
    
    
}

//SearchDelegate
extension SearchUthersTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchBar.text!, scope: scope)
    }
}

//SearchBar's Scope Bar delegate
extension SearchUthersTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
