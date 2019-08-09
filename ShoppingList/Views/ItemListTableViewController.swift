//
//  ItemListTableViewController.swift
//  ShoppingList
//
//  Created by Ian Hall on 8/9/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

/*  okay gameplan
 
 1. hook up iboutlets --complete
 2. clean up code actually do this first!!! -- Complete
 3. create button cell custom file -- bam done
 4. enable delegate functionality on this file from step 3 -complete
 5. do the fancy setup for the button cell -- complete
 6. hook up delete - complete
 7. enable notifications which will allow input
 
 */
import UIKit
import CoreData


class ItemListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.sharedInstance.shoppintList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //unwrap that cell making sure its of the correct type
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ItemTableViewCell else {return UITableViewCell()}
        
        //get the item
        let item = ItemController.sharedInstance.shoppintList[indexPath.row]
        
        // update cell
        cell.update(item: item)
        
        //cant forget to set the delegate
        cell.delegate = self
    
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = ItemController.sharedInstance.shoppintList[indexPath.row]
            ItemController.sharedInstance.delete(item: item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    //MARK: actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        addItemUsingNotifications()

       
    }
    func update(){
        
    }
    //MARK: helpers
    func addItemUsingNotifications(){
    let alert = UIAlertController(title: "New Item", message: "what do you want to add to your list", preferredStyle: .alert)
        alert.addTextField { (textField) in
        }
        alert.addAction(UIAlertAction(title: "add", style: .default, handler: { (action) in
            guard let newItem = alert.textFields?[0].text else {return}
            print(newItem)
           ItemController.sharedInstance.saveItem(name: newItem)
            self.reloadInputViews()

        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
        tableView.reloadData()
    }
}
//MARK: Extensions

// this is an extension from my custom cell it gets hit when my button yells at it
extension ItemListTableViewController: ItemTableViewCellDelegate{
    func cellSettingHasChanged(_ sender: ItemTableViewCell) {
        //get the index
        guard let index = tableView.indexPath(for: sender) else {return}
        
        //grab the item
        let item = ItemController.sharedInstance.shoppintList[index.row]
        


        //change the value and then resend to the cell to change the pic
        ItemController.sharedInstance.toggle(item: item)
        sender.updateButton(isPurchased: item.purchased)
        tableView.reloadRows(at: [index], with: .automatic)
    }
    
    
}


// this little guy makes it so i can delete stuff its probably overkill
extension ItemListTableViewController: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let newIndexPath = newIndexPath, let indexPath = indexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(indexSet, with: .automatic)
        default: return
        }
    }
}
