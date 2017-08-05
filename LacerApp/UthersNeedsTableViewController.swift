//
//  UthersNeedsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 16/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UthersNeedsTableViewController: UITableViewController {
   
    
    // MARK: - Properties
    
    var needs : [Need] = []

    var filteredNeeds = [Need]()
    
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
        searchController.searchBar.scopeButtonTitles = ["Mes mots-clés", "Autres"]
        searchController.searchBar.delegate = self
        
        loadSample()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive && searchController.searchBar.text != "") {
            return filteredNeeds.count
        }
         return needs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UtherNeedTableViewCell", for: indexPath) as? UtherNeedTableViewCell  else {
            fatalError("The dequeued cell is not an instance of UtherNeedTableViewCell.")
        }
        
        let need : Need
        
        if searchController.isActive && searchController.searchBar.text != "" {
            need = filteredNeeds[indexPath.row]
        } else {
            need = needs[indexPath.row]
        }
        
        cell.photoImageView.image = need.photo
        cell.titleLabel.text = need.title
        cell.usernameLabel.text = need.username
        cell.distanceLabel.text = String(Int(need.distance))+" m"
        
        return cell
    }
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    
    
    
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
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Tout") {
        filteredNeeds = needs.filter { need in
            let categoryMatch = (scope == "Tout") //|| (user.category == scope)
            return  categoryMatch && need.username.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }

    
    
    
    private func loadSample() {
        let photo = UIImage(named: "userPhoto")
        
        needs+=[
            Need(title: "Besoin Inedis", tags : "#java #mongo",activ:true, username : "Inedis", distance: 1230, description : "Bla bla bla", photo : photo),
            Need(title: "BNP : Ingenieur full stack", tags : "#javascript #cassandra #node.js",activ:false, username : "BNP", distance: 450, description : "Bla bla bla", photo : photo),
            Need(title: "Scrum master pour Google", tags : "#scrum #agilité",activ:true, username : "Google", distance: 204, description : "Bla bla bla", photo : photo),
        ]
    }
    
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

