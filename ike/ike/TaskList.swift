//
//  TaskLIst.swift
//  ike
//
//  Created by Gaetano Celentano on 26/10/22.
//

import SwiftUI


struct OrderChoices : View {
    @Binding var selected : Int
    var body: some View{
        Picker(selection: $selected, label: Text("Order Preference")) {
            ForEach(0..<choices.count, id: \.self) { index in
                Text(choices[index])
                    .onTapGesture {
                        selected = index
                }
                    
               }
        }
        .pickerStyle(SegmentedPickerStyle())
        
    }
}

struct TaskRow: View {
    @ObservedObject var item: Task
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    
    
    var body: some View{
        Text(item.taskName ?? "Unknown Task Name")
        Spacer()
        if item.deadline != nil {
            Text(item.deadline!.formatted(.dateTime.day().month().year()))
            .foregroundColor(Color("Deadline Text"))
            
            }
        }
       
    }
    


struct TaskList : View {
    
    
    
    @Environment(\.managedObjectContext) var moc
    
    @Binding var highlightPrio : String
    @Binding var order : Int
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.priority, order: .reverse)]) var PriorityOrderTasks : FetchedResults<Task>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.deadline, order: .forward)]) var DeadlineOrderTasks : FetchedResults<Task>
    
    var body: some View{
        List {
            ForEach(highlightPrio == "" ?
                    Array(order == 0 ? DeadlineOrderTasks : PriorityOrderTasks) :
                    Array((order == 0 ? DeadlineOrderTasks : PriorityOrderTasks).filter{priorities[Int($0.priority)]==highlightPrio}))
            {task in
                if !task.done {
                    NavigationLink(destination: detailsView(task: task)){
                        HStack{
                            TaskRow(item: task)
                        }
                        
                    }
                    .listRowBackground(Color("\(priorities[Int(task.priority)]) Task Priority"))
                    .swipeActions(content: {
                        Button(role: .destructive) {
                            moc.delete(task)
                            try? moc.save()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        Button{
                            task.done = true
                            
                            try? moc.save()
                        } label: {
                            Label("Done", systemImage: "checkmark")
                        }
                        
                    })}
            }
                    
            
        }
        
       
    }
   
    func delete (at offsets: IndexSet){
        for offset in offsets {
            let task = order == 0 ? DeadlineOrderTasks[offset] : PriorityOrderTasks[offset]
            moc.delete(task)
        }
        try? moc.save()
    }
    
}
