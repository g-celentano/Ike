//
//  TaskRow.swift
//  ike
//
//  Created by Gaetano Celentano on 27/10/22.
//

import SwiftUI


struct TaskRow: View {
    @ObservedObject var item: Task
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    
    
    var body: some View{
        Text(item.taskName ?? "Unknown Task Name")
        Spacer()
        Text((item.deadline != nil) ? item.deadline!.formatted(.dateTime.day().month().year()) : "")
            .foregroundColor(Color("Deadline Text"))
    }
    
    
}
