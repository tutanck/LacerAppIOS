//
//  SearchUthersNeedsTableViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 16/07/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class SearchUthersNeedsTableViewController: UITableViewController {
    
    
    
    var customerNeeds : [CustomerNeed] = []
    
    
    
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
        return customerNeeds.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerNeedTableViewCell", for: indexPath) as? CustomerNeedTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CustomerNeedTableViewCell.")
        }
        
        let customerNeed = customerNeeds[indexPath.row]
        
        cell.photoImageView.image = customerNeed.photo
        cell.titleLabel.text = customerNeed.title
        
        cell.customerNameLabel.text = customerNeed.customerName
        
        cell.distanceLabel.text = String(Int(customerNeed.distance))+" m"
        
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
    
    
    
    private func loadSample() {
        let photo = UIImage(named: "userPhoto")
        
        customerNeeds+=[
            CustomerNeed(title: "Besoin Inedis", tags : "#java #mongo",activ:true, customerName : "Inedis", distance: 1230, description : "Bla bla bla", photo : photo),
            CustomerNeed(title: "BNP : Ingenieur full stack", tags : "#javascript #cassandra #node.js",activ:false, customerName : "BNP", distance: 450, description : "Bla bla bla", photo : photo),
            CustomerNeed(title: "Scrum master pour Google", tags : "#scrum #agilité",activ:true, customerName : "Google", distance: 204, description : "Bla bla bla", photo : photo),
        ]
    }
    
}
