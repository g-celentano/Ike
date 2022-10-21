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


var tasks = [
    Task(taskName: "Study for the ADA", deadline: "26/10/2022", priority:"Schedule It"),
    Task(taskName: "Study MAPI", deadline: "25/10/2022", priority:"Do It"),
    Task(taskName: "Walk the dog", deadline: "25/10/2022", priority:"Delegate It"),
    Task(taskName: "Do the laundry", deadline: "25/10/2022", priority:"Delete It"),
]

struct TaskList: View {
    var body: some View {
        
        List {
            ForEach(tasks) { task in
                Text(task.taskName)
                    .listRowBackground(task.priority == "Do It" ? Color.red.opacity(0.8) :
                                        task.priority == "Schedule It" ? Color.orange.opacity(0.8) :
                                        task.priority == "Delegate It" ? Color.green.opacity(0.7) :
                                        task.priority == "Delete It" ? Color.yellow.opacity(0.7) : Color.gray)
                }
                    
        }
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
