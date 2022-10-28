//
//  TaskLIst.swift
//  ike
//
//  Created by Gaetano Celentano on 26/10/22.
//

import SwiftUI

struct OrderChoice : Identifiable{
    var id : Int
    var value : String
}
let choices = [
    OrderChoice(id: 1, value: "Order by DeadLine"),
    OrderChoice(id: 2, value: "Order by Priority"),
]

struct OrderChoices : View {
    @State var selected = choices[0].id
    var body: some View{
        Picker(selection: $selected, label: Text("Order Preference")) {
            ForEach(choices) { choice in
                Text(choice.value)
                    .onTapGesture {
                    selected = choice.id
                }
                    
               }
        }
        .pickerStyle(SegmentedPickerStyle())
        
    }
}


struct TaskList : View {
    
    @State var tasks : FetchedResults<Task>
    
    @Environment(\.managedObjectContext) var moc
    
    @Binding var highlightPrio : String
    
    var body: some View{
        List {
            ForEach(highlightPrio == "" ? Array(tasks) : Array(tasks.filter{priorities[Int($0.priority)]==highlightPrio})) {task in
                NavigationLink(destination: detailsView(task: task)){
                    HStack{
                        TaskRow(item: task)
                    }
                    
                }
                .listRowBackground(Color("\(priorities[Int(task.priority)]) Task Priority"))
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let task = tasks[index]
                    moc.delete(task)
                }
                try? moc.save()
            }
            
        }
        
       
    }
   
        
    
}
