//
//  UserKeywordsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 20/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserKeywordsTableViewController: UITableViewController {
    
    var keywords : [Keyword] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return keywords.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserKeywordTableViewCell", for: indexPath) as? UserKeywordTableViewCell  else {
            fatalError("The dequeued cell is not an instance of UserKeywordTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let keyword = keywords[indexPath.row]
        
        cell.titleLabel.text = keyword.title
        cell.statusSwitch.isOn = keyword.activ
        
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
    
    
    
    @IBAction func addKeywordAction(_ sender: UIBarButtonItem) {
        
        Alert.displayTextBox(context: self, message: "Ajoutez un mot-clé à votre activité", headerTitle : "Nouveau mot-clé", confirmButtonTitle : "Ajouter")
    }
    
    
    
    //MARK: Private Methods
    
    private func loadSample() {
        keywords+=[
            Keyword(title: "Java", activ:true),
            Keyword(title: "Mongo ", activ:false),
            Keyword(title: "Scrum",activ:true),
        ]
    }
    
    
    
    
}
