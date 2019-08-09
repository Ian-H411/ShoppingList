//
//  ItemController.swift
//  ShoppingList
//
//  Created by Ian Hall on 8/9/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation
import CoreData
class ItemController {
    //singleton
    static let sharedInstance = ItemController()
    
    //source of truth the origin of all
    var fetchedResultsController: NSFetchedResultsController<Item>
    
    init() {
        //first we create the fetch
        let fetch: NSFetchRequest<Item> = Item.fetchRequest()
        
        // then a results controller which we will punch in our fetch and context
        let resultsController: NSFetchedResultsController<Item> = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        // we then need to save the results controller outside the init so that way we can acsess it globally
        fetchedResultsController = resultsController
        
        //all thats left is to do try catch the fetch request
        do {
            try fetchedResultsController.performFetch()
        } catch {
            //it seems stupid but it will stand out and help me find the message faster
            print("--- fetchedresults --- " + error.localizedDescription)
        }
    }
    
    // cant forget the CRUD
    
    func createItem(name: String){
        //save it we dont care for a name coredata will handle the appending
        let _ = Item(name: name, purchased: false)
        saveToPersistenceStorage()
    }
    
    /* wont need an update function. assesment doesnt enable editing but ill leave it here commented out just in case
     func update(item: Item, name: String){
     }
     */
    
    func toggle(item: Item){
        //switch the items purchased back and forth
        item.purchased = item.purchased ? false : true
        saveToPersistenceStorage()
    }
    
    func delete(item: Item){
        //use the fancy CoreData deletion method
        item.managedObjectContext?.delete(item)
    }
    
    func saveToPersistenceStorage(){
        //acsess coredatastacks save functionality
        do {
            try CoreDataStack.context.save()
        } catch {
            print("--saveToPeristenceStorage--" + error.localizedDescription)
        }
    }
}
