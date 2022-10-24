//
//  task.swift
//  ike
//
//  Created by Gaetano Celentano on 22/10/22.
//

import SwiftUI

let priorities = [
"Delete It",
"Delegate It",
"Schedule It",
"Do It"
]


struct Task : Identifiable, Equatable{
    let id = UUID()
    var taskName : String
    var deadline: Date
    var priority: Int
    //var not_freq: Notification
  
}


struct TaskList: View {
    
    @State var tasks =  [
        Task(taskName: "Study for the ADA", deadline: Date(), priority:2),
        Task(taskName: "Study MAPI", deadline: Date(), priority:3),
        Task(taskName: "Walk the dog", deadline: Date(), priority:1),
        Task(taskName: "Do the laundry", deadline: Date(), priority:0),
    ]
    
    var body: some View {

                List {
                    ForEach(tasks) { task in
                       NavigationLink(destination:
                                        detailsView(task: task)
                                        /*detailsViewMatrix(task: task)*/){
                            HStack{
                                Text(task.taskName)
                                Spacer()
                                Text(task.deadline.formatted(.dateTime.day().month().year()))
                                    .foregroundColor(Color("Deadline Text"))
                            }
                            
                       }.listRowBackground(Color("\(priorities[task.priority]) Task Priority"))
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.plain)
    }
        
    
    func delete(at offsets: IndexSet) {
            tasks.remove(atOffsets: offsets)
        }
}


