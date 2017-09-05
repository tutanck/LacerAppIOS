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
    
    var keywords : [UserKeyword] = []
    
    
    // MARK: - System Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return keywords.count }
    
    //GET
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? KeywordTableViewCell  else {
            fatalError("The dequeued cell is not an instance of " + cellID)
        }
        
        // Fetches the appropriate meal for the data source layout.
        let keyword = keywords[indexPath.row]
        
        cell._id = keyword._id
        cell.keywordLabel.text = keyword.title
        cell.activSwitch.isOn = keyword.active
        
        return cell
    }
    
    
    
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
            UserKeywordsColl.deleteUserKeyword(_id: cell._id!, ack: { dataArray in print(dataArray) })
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
    
    
}
