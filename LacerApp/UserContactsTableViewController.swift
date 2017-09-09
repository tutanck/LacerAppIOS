//
//  UserContactsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 15/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class UserContactsTableViewController: UITableViewController {
    
    let cellID = "UserContactTableViewCell"
    
    
    var contacts : [User] = [
        User(_id:"", type : 1, username : "Joan"),
            User(_id:"", type : 1, username : "Jan"),
            User(_id:"", type : 0, username : "Jon"),
            User(_id:"", type : 1, username : "Jean")
    
        ]{
        didSet {
            updateSearchResults(for: searchController)
        }
    }

    
    var filteredContacts = [User]()
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    // MARK: - SwitchableControl
    
    @IBOutlet weak var userAvailabilitySwitchableControl: SwitchableColorButton!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
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
        searchController.searchBar.scopeButtonTitles = ["Tout","Particuliers","Entreprises"]
        searchController.searchBar.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let userID = UserInfos._id {
            IO.r.socket.on(UserMessagesColl.tag+"/"+userID, callback: {
                (dataArray, ackEmitter) in
                let ctx = dataArray[1] as! JSONObject
                let op = ctx["op"] as! Int
                if op == 2 || op == -1 {
                    self.loadData()
                }
            })
            
            loadData()
        }

    }
    
    
    
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if SearchBarManager.isFiltering(searchController) {
            return filteredContacts.count
        }
        return contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? UserContactTableViewCell   else {
            fatalError("The dequeued cell is not an instance of " + cellID)
        }
        
        cell.context = self
        
        let contact : User
            
        if SearchBarManager.isFiltering(searchController) {
            contact = filteredContacts[indexPath.row]
        }else{
            contact = contacts[indexPath.row]
        }
        
        cell.nameLabel.text = contact.username
        cell.messageLabel.text = "TODO"
        cell.profileImageView.image = contact.photo
        
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
    
    //Mark : unwinds
    
    @IBAction func cancelFromSearchUser(segue:UIStoryboardSegue) {}
    
    
    
    //Mark : data loading

    private func loadData(){ UserMessagesColl.findUserIntelocutors(ack: dataDidLoad) }
    
    private func dataDidLoad(dataArray : [Any])->(){
        Waiter.popNServ(context: self, dataArray: dataArray, drink: {res in
            if let res = res as? JSONArray {

                var tmp : [User] = []
                
                for item in res {
                    tmp.append(User(snapshot: item))
                }
                
                self.contacts = tmp
                self.tableView.reloadData()
                
            }
        })
    }
    
    
    
    
    //MARK: Search Logic
    
    func filterContentFor(_ searchText: String, scope: String = "Tout") {
        filteredContacts = contacts.filter({
            (contact : User) -> Bool in
            
            var doesScopeMatch = false
            
            if (scope == "Tout"){
                doesScopeMatch = true
            } else if scope == "Particuliers" && contact.type == 0 {
                doesScopeMatch = true
            } else if scope == "Entreprises" && contact.type == 1 {
                doesScopeMatch = true
            }
            
            let searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if searchText.isEmpty {
                return doesScopeMatch
            } else {
                return doesScopeMatch && contact.username.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }

    
    
}



//SearchDelegate
extension UserContactsTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentFor(searchController.searchBar.text!, scope: scope)
    }
}

//SearchBar's Scope Bar delegate
extension UserContactsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentFor(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

