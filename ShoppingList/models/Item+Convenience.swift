//
//  Item+Convenience.swift
//  ShoppingList
//
//  Created by Ian Hall on 8/9/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    convenience init (name: String, purchased: Bool, moc: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: moc)
        self.name = name
        self.purchased = purchased
        
    }
}
