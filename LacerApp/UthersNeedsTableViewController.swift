//
//  UthersNeedsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 16/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class UthersNeedsTableViewController: UITableViewController {
    
    
    let cellId = "UtherNeedTableViewCell"
    
    
    // MARK: - Properties
    
    var needs : [UtherNeed] = [
      UtherNeed(_id : String(),
        title : String(),
        active : false,
        searchText : String(),
        ownerID : String(),
        description : String(),
        reward : String(),
        place : String(),
        time : String())
    ]
    
    
    var filteredNeeds = [UtherNeed]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    // MARK: - SwitchableControl
    
    @IBOutlet weak var userAvailabilitySwitchableControl: SwitchableColorButton!
    
    
    
    // MARK: - System events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //user status button settings
        userAvailabilitySwitchableControl.context = self
        
        //SearchController parameters
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        //SearchController's search bar parameters
        searchController.searchBar.scopeButtonTitles = ["Mes mots-clés", "Autres"]
        searchController.searchBar.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive && searchController.searchBar.text != "") {
            return filteredNeeds.count
        }
        return needs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UtherNeedTableViewCell  else {
            fatalError("The dequeued cell is not an instance of "+cellId)
        }
        
        let need : UtherNeed
        
        if searchController.isActive && searchController.searchBar.text != "" {
            need = filteredNeeds[indexPath.row]
        } else {
            need = needs[indexPath.row]
        }
        
        cell.context = self
        cell.utherNeedMenu.context = self
        cell.need = need
        cell.userProfileImageView.image = UIImage(named : "userPhoto")
        cell.titleLabel.text = need.title
        cell.usernameLabel.text = need.ownerID
        cell.typeLabel.text = "Entreprise"
        //cell.distanceLabel.text = String(Int(need.distance))+" m" //TODO
        let textView = cell.scrollViewContainer.setText(text: "#keyword #keyword #keyword #keyword #keyword #keyword #keyword#", fontSize: 16)
        textView.textColor = .darkGray
        textView.backgroundColor = UIColor(white : 0.995, alpha : 1)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cell.selectionStyle = .none
    }
    
    
    
    
    //MARK: Search Logic
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Tout") {
        filteredNeeds = needs.filter { need in
            let categoryMatch = (scope == "Tout") //|| (user.category == scope)
            return  categoryMatch && need.ownerID.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    
    
    
    
    //Mark : unwinds
    
    @IBAction func cancelFromContactsSelection(segue:UIStoryboardSegue) {}
    
    //Mark : unwinds
    
    @IBAction func doneFromContactsSelection(segue:UIStoryboardSegue) {}
}



//SearchDelegate
extension UthersNeedsTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

//SearchBar's Scope Bar delegate
extension UthersNeedsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

