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
    
    var body: some View{
        List {
            ForEach(tasks) {task in
                NavigationLink(destination: detailsView(task: task)){
                    HStack{
                        TaskRow(item: task)
                    }
                    
                }
                .listRowBackground(Color("\(priorities[Int(task.priority)]) Task Priority"))
            }
            .onDelete { indexSet in
                for index in indexSet {
                    moc.delete(tasks[index])
                }
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
        .listStyle(.plain)
        
    }
   
        
    
}
