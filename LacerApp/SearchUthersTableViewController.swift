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
    
    var users = [User]()
    
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
        searchController.searchBar.scopeButtonTitles = ["Tout","Particuliers","Entreprises"]
        searchController.searchBar.delegate = self
    }
    
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return users.count }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? SearchUthersTableViewCell  else {
            fatalError("The dequeued cell is not an instance of " + cellID)
        }
        
        let user = users[indexPath.row]
        
        cell._id = user._id
        cell.nameLabel.text = user.username
        cell.messageLabel.text = ""
        cell.timeLabel.text = ""
        cell.profileImageView.image = user.photo
        
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "segueFromSearchUthersToUtherProfil":
            guard let utherProfileController = segue.destination as? UtherProfileViewController else {
                fatalError("The segue.destination is not an instance of UtherProfileViewController.")
            }
            
            guard let selectedCell = sender as? SearchUthersTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedUther = users[indexPath.row]
            
            utherProfileController._id =  selectedUther._id
            
        default:return
        }
    }
    
    
    
    //MARK: Search Logic
    
    func loadDataFor(_ searchText: String, scope: String = "Tout") {
        
        let searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if searchText.isEmpty{ return }
        
        if scope == "Tout"{
            UserProfilesColl.findProfiles(username : searchText, ack: dataDidLoad)
        }else{
            var type : Int = 0
            if scope == "Entreprises" { type = 1 }
            UserProfilesColl.findProfiles(username : searchText, type : type, ack: dataDidLoad)
        }
        
    }
    
    
    private func dataDidLoad(dataArray : [Any])->(){
        Waiter.popNServ(context: self, dataArray: dataArray, drink: {res in
            if let res = res as? JSONArray {
                
                var tmp : [User] = []
                
                for item in res {
                    tmp.append(User(snapshot: item))
                }
                
                self.users = tmp
                self.tableView.reloadData()
                
            }
        })
    }
    
    
}

//SearchDelegate
extension SearchUthersTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        loadDataFor(searchController.searchBar.text!, scope: scope)
    }
}

//SearchBar's Scope Bar delegate
extension SearchUthersTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        loadDataFor(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
