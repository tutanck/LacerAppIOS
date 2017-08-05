//
//  NeedsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 15/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserNeedsTableViewController: UITableViewController {
    
    var needs : [Need] = []
    
    var filteredNeeds = [Need]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SearchController parameters
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
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
        return needs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserNeedTableViewCell", for: indexPath) as? UserNeedTableViewCell  else {
            fatalError("The dequeued cell is not an instance of UserNeedTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let need = needs[indexPath.row]
        
        cell.titleLabel.text = need.title
        
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
    
    func filterContentForSearchText(_ searchText: String) {
        filteredNeeds = needs.filter { need in
             return need.username.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }

    
    
    //MARK: Private Methods
    
    private func loadSample() {
        needs+=[
            Need(title: "Besoin Inedis", tags : "#java #mongo",activ:true, username: "Lol", distance: 20, description: "desc", photo: UIImage()),
            Need(title: "BNP : Ingenieur full stack", tags : "#javascript #cassandra #node.js",activ:false,username: "Lol", distance: 20, description: "desc", photo: UIImage()),
            Need(title: "Scrum master pour Google", tags : "#scrum #agilité",activ:true,username: "Lol", distance: 20, description: "desc", photo: UIImage())
        ]
    }
    
    
    //Mark : unwinds
    
    @IBAction func cancelFromNeed(segue:UIStoryboardSegue) {}
    
    @IBAction func saveFromNeed(segue:UIStoryboardSegue) {}
    
    
}



//SearchDelegate
extension UserNeedsTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
