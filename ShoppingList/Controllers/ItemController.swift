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
    static var sharedInstance = ItemController()
    
    //source of truth the origin of all
    var shoppintList:[Item]
    
    init(){
        let fetch: NSFetchRequest<Item> = Item.fetchRequest()
        shoppintList = (try? CoreDataStack.context.fetch(fetch)) ?? []
    }

    // cant forget the CRUD
    
    func saveItem(name: String){
        //save it we dont care for a name coredata will handle the appending
        let _ = Item(name: name, purchased: false)
        saveToPersistenceStorage()
    }

    
    func toggle(item: Item){
        //switch the items purchased back and forth
        item.purchased = item.purchased ? false : true
        saveToPersistenceStorage()
    }
    
    func delete(item: Item){
        //use the fancy CoreData deletion method
        guard let index = shoppintList.firstIndex(of: item) else {return}
        shoppintList.remove(at: index)
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
