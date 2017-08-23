//
//  UserKeywordsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 20/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit
import Firebase

class UserKeywordsTableViewController: UITableViewController {
    
    var keywords : [Keyword] = []
    
    
    //MARK: Firef
    
    var ref : DatabaseReference? = nil{
        didSet {
            loadFireData()
        }
    }
    
    
    
    // MARK: - System Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //firef settings
        if let userID = Auth.auth().currentUser?.uid{
            let userRef = Fire.usersRef.child(userID)
            self.ref = userRef.child(Fire.userKeywordsKey)
        }
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
        return keywords.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KeywordTableViewCell", for: indexPath) as? KeywordTableViewCell  else {
            fatalError("The dequeued cell is not an instance of KeywordTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let keyword = keywords[indexPath.row]
        
        cell.keywordLabel.text = keyword.title
        cell.activSwitch.isOn = keyword.activ
        //cell.ref = keyword.ref
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let keyword = keywords[indexPath.row]
            keyword.ref?.removeValue()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? KeywordTableViewCell else { return }
        Alert.displayTextBox(context: self,  message: "Modifiez le mot-clé de votre activité",
                             handler : { text in
                                //cell.ref?.removeValue()
                                //self.ref?.child(text.lowercased()).setValue(true)
        },headerTitle:  "Modification", textBoxText : "cell.ref!.key"
        )
    }
    
    
    @IBAction func addKeywordAction(_ sender: UIBarButtonItem) {
        Alert.displayTextBox(context: self, message: "Ajoutez un mot-clé à votre activité",
                             handler : { text in self.ref?.child(text.lowercased()).setValue(true)},
                             headerTitle : "Nouveau mot-clé",confirmButtonTitle : "Ajouter")
    }
    
    
    
    //MARK: Private Methods
    private func loadFireData(){
        if let ref = self.ref {
            ref.queryOrderedByValue().observe(.value, with: { snapshot in
                var tmp : [Keyword] = []
                
                for item in snapshot.children {
                    tmp.append(Keyword(snapshot: item as! DataSnapshot))
                }
                
                self.keywords = tmp//.reversed() //TODO : find a way
                self.tableView.reloadData()
            })
        }
    }
    
}
