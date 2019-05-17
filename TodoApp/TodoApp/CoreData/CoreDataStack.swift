//
//  CoreDataStack.swift
//  TodoApp
//
//  Created by Maciej Golianek on 16/05/2019.
//  Copyright © 2019 Maciej Golianek. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack  {
    var container: NSPersistentContainer {
        let container = NSPersistentContainer(name: "Todos")
        container.loadPersistentStores { (description, error) in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
        }
        
        return container
    }
    
    var managedContext: NSManagedObjectContext {
        return container.viewContext
    }
}
