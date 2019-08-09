//
//  ItemListTableViewController.swift
//  ShoppingList
//
//  Created by Ian Hall on 8/9/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

/*  okay gameplan
 
 1. hook up iboutlets
 2. clean up code actually do this first!!! -- Complete
 3. create button cell custom file
 4. enable delegate functionality on this file from step 3
 5. do the fancy setup for the button cell
 6. hook up delete
 7. enable notifications which will allow input
 
 */
import UIKit

class ItemListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
