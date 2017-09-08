//
//  NeedsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 15/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class UserNeedsTableViewController: UITableViewController {
    
    let cellId = "UserNeedTableViewCell"
    
    
    // MARK: - Properties
    
    var needs : [UserNeed] = []{
        didSet {
            updateSearchResults(for: searchController)
        }
    }
    
    var filteredNeeds = [UserNeed]()

    
    let searchController = UISearchController(searchResultsController: nil)

    
    // MARK: - SwitchableControl
    
    @IBOutlet weak var userAvailabilitySwitchableControl: SwitchableColorButton!
    
    
    
    // MARK: - System Events
    
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
        searchController.searchBar.scopeButtonTitles = ["Tout", "Actifs", "Inactifs"]
        searchController.searchBar.delegate = self
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let userID = UserInfos._id {
            IO.r.socket.on(UserNeedsColl.tag+"/"+userID, callback: {
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
            return filteredNeeds.count
        }
        return needs.count
    }
    
    
    //GET
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UserNeedTableViewCell  else {
            fatalError("The dequeued cell is not an instance of" + cellId)
        }
        
        let need : UserNeed
            
        if SearchBarManager.isFiltering(searchController) {
            need = filteredNeeds[indexPath.row]
        }else{
            need = needs[indexPath.row]
        }
        
        cell._id = need._id
        cell.titleLabel.text = need.title
        cell.previewLabel.text = need.searchText
        cell.timeLabel.text = "TODO"
        cell.isActivImageView.backgroundColor = need.active ? .green : .red
        
        return cell
    }
    
    
    //DELETE
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserNeedTableViewCell else { return }
        
        if editingStyle == .delete {
            Reaper.delete(
                coll: UserNeedsColl.name ,
                _id: cell._id!,
                meta : UserNeedSnap.meta,
                ack: { dataArray in print(dataArray) }
            )
        }
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "modalUpdateUserNeed":
            guard let destinationNavigationController = segue.destination as? UINavigationController else {
                fatalError("Unexpected UINavigationController destination: \(segue.destination)")
            }
            
            guard let needDetailViewController = destinationNavigationController.topViewController as? UserNeedDetailsViewController else {
                fatalError("Unexpected UINavigationController.topViewController destination: \(segue.destination)")
            }
            
            
            guard let selectedNeedCell = sender as? UserNeedTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedNeedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedNeed : UserNeed
            
            if SearchBarManager.isFiltering(searchController) {
                selectedNeed = filteredNeeds[indexPath.row]
            }else{
                selectedNeed = needs[indexPath.row]
            }
            
            needDetailViewController._id =  selectedNeed._id
            
        default:return
        }
    }
    
    
    
    
    //MARK: Private Methods
    
    private func loadData(){ UserNeedsColl.findUserNeeds(ack: dataDidLoad) }
    
    private func dataDidLoad(dataArray : [Any])->(){
        Waiter.popNServ(context: self, dataArray: dataArray, drink: {res in
            if let res = res as? JSONArray {
                
                var tmp : [UserNeed] = []
                
                for item in res {
                    tmp.append( UserNeed(snapshot: item) )
                }
                
                self.needs = tmp
                self.tableView.reloadData()
            }
        })
    }
    
    
    //Mark : unwinds
    
    @IBAction func cancelFromNeed(segue:UIStoryboardSegue) {}
    
    
    
    
    
    //MARK: Search Logic
    
    func filterContentFor(_ searchText: String, scope: String = "Tout") {
        filteredNeeds = needs.filter({
            (need : UserNeed) -> Bool in
            
            var doesScopeMatch = false
            
            if (scope == "Tout"){
                doesScopeMatch = true
            } else if scope == "Actifs" && need.active {
                doesScopeMatch = true
            } else if scope == "Inactifs" && !need.active {
                doesScopeMatch = true
            }
            
            let searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if searchText.isEmpty {
                return doesScopeMatch
            } else {
                return doesScopeMatch && need.title.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }

    
}



//SearchDelegate
extension UserNeedsTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentFor(searchController.searchBar.text!, scope: scope)
    }
}

extension UserNeedsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentFor(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
