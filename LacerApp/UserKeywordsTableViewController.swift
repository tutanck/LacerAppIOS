//
//  UserKeywordsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 20/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit


class UserKeywordsTableViewController: UITableViewController {
    
    let cellID = "KeywordTableViewCell"
    
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
        
        //SearchController's search bar parameters
        searchController.searchBar.scopeButtonTitles = ["Tout", "Actifs", "Inactifs"]
        searchController.searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let userID = UserInfos._id {
            IO.r.socket.on(UserKeywordsColl.tag+"/"+userID, callback: {
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
            return filteredKeywords.count
        }
        return keywords.count
    }
    
    
    //GET
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? KeywordTableViewCell  else {
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
        cell.activSwitch.isOn = keyword.active
        
        return cell
    }
    
    
    //EDITABLE
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    
    
    //ADD
    @IBAction func addKeywordAction(_ sender: UIBarButtonItem) {
        Alert.displayTextBox(context: self,
                             headerTitle : "Nouveau mot-clé",
                             message: "Ajoutez un mot-clé à votre activité",
                             handler : { text in
                                if !text.isAlphanum {
                                    Alert.displayMessage(context: self, headerTitle: "Mot-clé invalide",message: "Un mot-clé doit être composé uniquement de caractères alphanumériques" , confirmable : false,displayDuration : 3)
                                }else {
                                    UserKeywordSnap(
                                        title: text,
                                        ack: { dataArray in print("Snap : \(dataArray)") }
                                    )
                                }},
                             confirmButtonTitle : "Ajouter")
        
    }
    
    
    
    
    //UPDATE
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? KeywordTableViewCell else { return }
        
        Alert.displayTextBox(context: self,
                             headerTitle:  "Modification",
                             message: "Modifiez le mot-clé de votre activité",
                             handler : { text in
                                UserKeywordSnap(
                                    _id : cell._id!,
                                    title: text,
                                    ack: { dataArray in print("Snap : \(dataArray)") }
                                )
        }, textBoxText : cell.keywordLabel.text)
    }
    
    
    
    
    
    //DELETE
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? KeywordTableViewCell else { return }
        
        if editingStyle == .delete {
            Reaper.delete(
                coll: UserKeywordsColl.name ,
                _id: cell._id!,
                meta : UserKeywordSnap.meta,
                ack: { dataArray in print(dataArray) }
            )
        }
    }
    
    
    
    
    private func loadData(){ UserKeywordsColl.findUserKeywords(ack: dataDidLoad) }
    
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
    
    func filterContentFor(_ searchText: String, scope: String = "Tout") {
        filteredKeywords = keywords.filter({
            (keyword : UserKeyword) -> Bool in
            
            var doesScopeMatch = false
            
            if (scope == "Tout"){
                doesScopeMatch = true
            } else if scope == "Actifs" && keyword.active {
                doesScopeMatch = true
            } else if scope == "Inactifs" && !keyword.active {
                doesScopeMatch = true
            }
            
           let searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if searchText.isEmpty {
                return doesScopeMatch
            } else {
                return doesScopeMatch && keyword.title.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    
    
}


//SearchDelegate
extension UserKeywordsTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentFor(searchController.searchBar.text!, scope: scope)
    }
}

extension UserKeywordsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentFor(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

