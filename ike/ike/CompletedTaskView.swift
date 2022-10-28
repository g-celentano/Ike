//
//  CompletedTaskView.swift
//  ike
//
//  Created by Gaetano Celentano on 28/10/22.
//

import SwiftUI

struct CompletedTaskView: View {
    
    @FetchRequest(sortDescriptors: []) var tasks : FetchedResults<Task>
    
    @Environment(\.managedObjectContext) private var moc
    
    var body: some View {
        VStack{
            List{
                ForEach(tasks){ task in
                    if task.done {
                        Text(task.taskName ?? "Unknown task name").listRowBackground(Color("\(priorities[Int(task.priority)]) Task Priority"))
                    }
                }.onDelete(perform: delete)
                
            }
            .frame(width: screenWidth*0.9, height: screenHeight*0.85)
            .cornerRadius(20)
        }.navigationTitle("Completed Tasks")
    }
    func delete(at offsets: IndexSet){
        for offset in offsets {
            let task = tasks[offset]
            moc.delete(task)
        }
        try? moc.save()
    }
}

struct CompletedTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedTaskView()
    }
}
