//
//  UserContactsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 15/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserContactsTableViewController: UITableViewController {
    
    
    var contacts : [User] = []
    
    var filteredContacts = [User]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - SwitchableControl
    
    @IBOutlet weak var userAvailabilitySwitchableControl: SwitchableColorButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userAvailabilitySwitchableControl.context = self
        
        //SearchController parameters
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        //SearchController's search bar parameters
        searchController.searchBar.scopeButtonTitles = ["Particuliers","Entreprises"]
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
        return contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ContactTableViewCell.")
        }
        
        let contact = contacts[indexPath.row]
        
        cell.usernameLabel.text = contact.name
        cell.photoImageView.image = contact.photo
        cell.userstatusLabel.backgroundColor = StatusColor.getColor(status : contact.status)
        
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    //MARK: Search Logic
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Tout") {
        filteredContacts = contacts.filter { contact in
            let categoryMatch = (scope == "Tout") //|| (user.category == scope)
            return  categoryMatch && contact.name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    
    //MARK: Private Methods
    
    private func loadSample() {
        let photo = UIImage(named: "userPhoto")
        contacts+=[
            User(name: "Angb joan", photo: photo, status: 1),
            User(name: "Diogo Justino", photo: photo, status: 0),
            User(name: "Tesla", photo: photo, status: 2)
        ]
    }
    
    
    
    
    //Mark : unwinds
    
    @IBAction func cancelFromSearchUser(segue:UIStoryboardSegue) {}

    
}



//SearchDelegate
extension UserContactsTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

//SearchBar's Scope Bar delegate
extension UserContactsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

