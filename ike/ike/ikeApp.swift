//
//  ikeApp.swift
//  ike
//
//  Created by Gaetano Celentano on 19/10/22.
//

import SwiftUI




@main
struct ikeApp: App {
    
    @StateObject private var dataController = DataController()
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                
        }
    }

}
