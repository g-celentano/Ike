//
//  DataController.swift
//  ike
//
//  Created by Gaetano Celentano on 26/10/22.
//
import CoreData
import Foundation

class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "Tasks")
    
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            
        }
    }
    
    
    
    
    
}
