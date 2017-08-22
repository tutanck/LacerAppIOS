//
//  NeedsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 15/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class UserNeedsTableViewController: UITableViewController {
    
    let cellId = "UserNeedTableViewCell"
    
    // MARK: - Properties
    
    var needs : [BacicNeed] = []
    
    var filteredNeeds = [BacicNeed]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - SwitchableControl
    
    @IBOutlet weak var userAvailabilitySwitchableControl: SwitchableColorButton!
    
    
    //MARK: Firef
    
    var ref : DatabaseReference? = nil{
        didSet {
            loadFireData()
        }
    }
    
    
    
    // MARK: - System Events
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //user status button settings
        userAvailabilitySwitchableControl.context = self
        
        //firef settings
        if let userID = Auth.auth().currentUser?.uid{
            let userRef = Fire.usersRef.child(userID)
            userAvailabilitySwitchableControl.ref = userRef.child(Fire.userStatusKey)
            self.ref = userRef.child(Fire.userNeedsKey)
        }
        
        //SearchController parameters
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
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
        return needs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UserNeedTableViewCell  else {
            fatalError("The dequeued cell is not an instance of"+cellId)
        }
        
        // Fetches the appropriate meal for the data source layout.
        let need = needs[indexPath.row]
        
        //cell.titleLabel.text = need.title
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let need = needs[indexPath.row]
            need.ref?.removeValue()
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
            needDetailViewController.preparedRef = selectedNeed.ref
            
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
    
    private func loadFireData(){
        if let ref = self.ref {
            ref.observe(.value, with: { snapshot in
                var tmp : [BacicNeed] = []
                
                for item in snapshot.children {
                    tmp.append( BacicNeed(snapshot: item as! DataSnapshot) )
                }
                
                self.needs = tmp
                self.tableView.reloadData()
            })
        }
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
