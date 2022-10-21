//
//  ikeApp.swift
//  ike
//
//  Created by Gaetano Celentano on 19/10/22.
//

import SwiftUI


struct OrderChoice : Identifiable{
    let id = UUID()
    var value : String
}
let choices = [
    OrderChoice(value: "Order by DeadLine"),
    OrderChoice(value: "Order by Priority"),
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


struct Task : Identifiable{
    let id = UUID()
    var taskName : String
    var deadline: String
    var priority: String
    //var not_freq: Notification
    
}



struct TaskList: View {
    @State var tasks = [
        Task(taskName: "Study for the ADA", deadline: "26/10/2022", priority:"Schedule It"),
        Task(taskName: "Study MAPI", deadline: "25/10/2022", priority:"Do It"),
        Task(taskName: "Walk the dog", deadline: "29/10/2022", priority:"Delegate It"),
        Task(taskName: "Do the laundry", deadline: "21/10/2022", priority:"Delete It"),
    ]
    
    var body: some View {
       
        List {
            ForEach(self.tasks.indices) { idx in
                HStack{
                    Text(self.tasks[idx].taskName)
                    Spacer()
                    Text(self.tasks[idx].deadline)
                        .foregroundColor(Color("Deadline Text"))
                       
                   
                }
                .listRowBackground(Color("\(self.tasks[idx].priority) Task Priority"))
                .swipeActions {
                        //--------------delete task button
                        Button(action: {
                          
                           
                        }) {
                            Image(systemName: "trash").imageScale(.large)
                        }.tint(Color("Delete Task"))
                        //--------------complete task button
                        Button(action: {}) {
                            Image(systemName: "checkmark").imageScale(.large)
                        }.tint(Color("Complete Task"))
                    
                }
            }
        }.listStyle(.plain)
    }
}


@main
struct ikeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

}
