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
    
    var needs : [UserNeed] = []
    
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
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return needs.count }
    
    //GET
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UserNeedTableViewCell  else {
            fatalError("The dequeued cell is not an instance of" + cellId)
        }
        
        // Fetches the appropriate meal for the data source layout.
        let need = needs[indexPath.row]
        
        cell._id = need._id
        cell.titleLabel.text = need.title
        cell.previewLabel.text = need.searchText
        cell.timeLabel.text = need._date.description
        cell.isActivImageView.backgroundColor = need.active ? .green : .red
        
        return cell
    }
    
    
    //DELETE
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      guard let cell = tableView.cellForRow(at: indexPath) as? KeywordTableViewCell else { return }
        
        if editingStyle == .delete {
            //UserNeedsColl.delete //TODO
            
        }
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
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
            
            let selectedNeed = needs[indexPath.row]
            needDetailViewController._id =  selectedNeed._id
            
        default:return
        }
    }
    
    
    
    //MARK: Search Logic
    
    func filterContentForSearchText(_ searchText: String) {
        filteredNeeds = needs.filter { need in
            return need.title.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
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
    
}



//SearchDelegate
extension UserNeedsTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
