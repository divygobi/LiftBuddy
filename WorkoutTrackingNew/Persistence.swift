//
//  Persistence.swift
//  Devote
//
//  Created by Divy Gobiraj on 9/6/21.
//

import CoreData
//MARK - 1. persistence controller

struct PersistenceController {
    static let shared = PersistenceController()
  
    //MARK - 2. persistence container
    let container: NSPersistentContainer
   
    //MARK - 3. initialization(loads up
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Workout")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    //MARK - 4. preview hi

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
           
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

   


}

