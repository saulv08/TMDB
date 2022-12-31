//
//  CoreDataStack.swift
//  TMDB
//
//  Created by Saul Perez Vasquez on 30/12/22.
//

import CoreData

func createContainer(completion: @escaping (NSPersistentContainer) -> ()) {
    let containter = NSPersistentContainer(name: "CoreData")
    containter.loadPersistentStores { _, error in
        guard error == nil else {
            fatalError("Failed to load store: \(error!)")
        }
        DispatchQueue.main.async {
            completion(containter)
        }
    }
}
