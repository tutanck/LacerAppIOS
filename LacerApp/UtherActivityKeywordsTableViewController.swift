//
//  UtherActivityKeywordsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 08/09/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UtherActivityKeywordsTableViewController: UITableViewController {
    
    let cellID = "UtherActivityKeywordTableViewCell"
    
    
    var ownerID : String?
    
    
    var keywords : [UserKeyword] = []{
        didSet {
            updateSearchResults(for: searchController)
        }
    }
    
    
    var filteredKeywords = [UserKeyword]()
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - System Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if SearchBarManager.isFiltering(searchController) {
            return filteredKeywords.count
        }
        return keywords.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? UtherActivityKeywordTableViewCell  else {
            fatalError("The dequeued cell is not an instance of " + cellID)
        }
        
        let keyword : UserKeyword
        
        if SearchBarManager.isFiltering(searchController) {
            keyword = filteredKeywords[indexPath.row]
        }else{
            keyword = keywords[indexPath.row]
        }
        
        cell._id = keyword._id
        cell.keywordLabel.text = keyword.title
        
        return cell
    }
    
    
    
    
    private func loadData(){
        if let ownerID = ownerID {
            UserKeywordsColl.findUtherKeywords(utherID: ownerID, ack: dataDidLoad)
        }else{
            Waiter.isConfused(self)
        }
    }
    
    private func dataDidLoad(dataArray : [Any])->(){
        Waiter.popNServ(context: self, dataArray: dataArray, drink: {res in
            if let res = res as? JSONArray {
                
                var tmp : [UserKeyword] = []
                
                for item in res {
                    tmp.append(UserKeyword(snapshot: item))
                }
                
                self.keywords = tmp
                self.tableView.reloadData()
                
            }
        })
    }
    
    
    
    
    
    //MARK: Search Logic
    
    func filterContentFor(_ searchText: String) {
        filteredKeywords = keywords.filter({
            (keyword : UserKeyword) -> Bool in
            
            let searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if searchText.isEmpty {
                return true
            } else {
                return keyword.title.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    
    
}


//SearchDelegate
extension UtherActivityKeywordsTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentFor(searchController.searchBar.text!)
    }
}
