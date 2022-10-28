//
//  ContentView.swift
//  ike
//
//  Created by Gaetano Celentano on 19/10/22.
//

let priorities = [
"Delete It",
"Delegate It",
"Schedule It",
"Do It"
]

let NotFrequencies = [
    "No Notifications",
    "Every Hour",
    "Every Two Hours",
    "Every Three Hours",
    "Every Four Hours",
    "Every Five Hours",
    "Every Ten Hours",
    "Every Day",
    "Every Two Days",
    "Every Three Days",
    "Every Four Days",
    "Every Five Days",
    "Every Six Days",
    "Every Week",
    "Every Week and a half",
    "Every Two Weeks",
]

import SwiftUI
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height


struct ContentView: View {
    //getting the screen boundaries for sizing and placing
   
    @State private var isPresented = false
    
    @State var highlightPrio = ""
    @Environment(\.managedObjectContext) var moc
    
    
    @FetchRequest(sortDescriptors: []) var tasks : FetchedResults<Task>
    
    
    
    var body: some View {
        
        NavigationStack{
         
        VStack {
            // horizontal stack for the actions------------------------------------------------------
            HStack{
                
                Button {
                    isPresented.toggle()
                } label:
                {
                    Image(systemName: "plus.circle")
                        .foregroundColor(Color("Add task button"))
                        .font(.largeTitle)
                }
                .padding(.trailing, screenWidth*0.05)
                .sheet(isPresented: $isPresented){
                    AddTaskModalView()
                }
                
          
        }
        .frame(width: screenWidth, alignment: .trailing)
        .padding(.top, screenHeight*0.05)
        
        
        
        //space reserved for the pie chart------------------------------------------------------
        ZStack{
            pieView(tasks: tasks, highPrio: $highlightPrio)
        }
        .frame(width: screenWidth * 0.65,height: screenWidth * 0.65)
        .padding(.bottom, screenHeight*0.05)
        
        
        
        //space for the priority switch------------------------------------------------------
        HStack{
            OrderChoices()
        }
        .frame(width: screenWidth*0.9)
        
        // space for the task list------------------------------------------------------
        VStack{
            TaskList(tasks: tasks, highlightPrio: $highlightPrio )
                .cornerRadius(10)
               
            //aggiungi funziona, però non si aggiorna la vista
            //ordina in base al pulsante
        }
        .frame(width: screenWidth*0.9)
        .padding(.bottom, screenHeight*0.05)
        
        
    }
        .frame(width: screenWidth, height: screenHeight, alignment: .top)
        .background(Color("BG"))
         
        
    }
    }
}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}*/

//modal view for the add of a new task

struct AddTaskModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    
    
    @State var modalTaskName = ""
    @State private var urgent = false
    @State private var important = false
    @State var priority = 0
    @State var selectedDate = Date()
    @State var selectedNotFreq="Every Day"
    @State var wantsDeadline = false
    @State var deadlineOpacity = 0.0

    var body: some View {
        ZStack{
            ScrollView{
                VStack {
                    HStack{
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "x.circle")
                                .foregroundColor(Color("Add task button"))
                                .font(.largeTitle)
                        }
                        .padding(.trailing, screenWidth*0.05)
                    }
                        .frame(width: screenWidth, alignment: Alignment.trailing)
                        .padding(.top, screenHeight*0.02)
                    
                    Text("Add New Task")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .frame(width: screenWidth*0.9, alignment: .leading)
                    
                    
                    HStack{
                        TextField("Task Name", text: $modalTaskName ).font(.title3)
                        Button(action:{
                            modalTaskName = ""
                        }){
                            Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
                        }
                        
                    }
                    .frame(height: screenHeight*0.05)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.gray.opacity(0.4))
                            .frame(width: nil,height: 1),
                        alignment: .bottom
                    )
                    .padding(EdgeInsets(top: 10, leading: screenWidth*0.05, bottom: 0, trailing: screenWidth*0.05))
                    
                    
                    HStack{
                        HStack{
                            Text("Deadline")
                                .frame(width: screenWidth*0.23)
                                .font(.title3)
                                .fontWeight(.bold)
                                
                            Toggle("", isOn: $wantsDeadline)
                                .onChange(of: wantsDeadline) { newValue in
                                if newValue {
                                    deadlineOpacity = 1
                                } else {
                                    deadlineOpacity = 0
                                }
                            }
                            
                        }
                        Spacer()
                        HStack{
                           
                            HStack{
                                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                                Image(systemName: "calendar").imageScale(.large)
                            }
                            .opacity(deadlineOpacity)
                            .animation(.linear, value: deadlineOpacity)
                            
                            
                            
                        }
                        .frame(width: screenWidth*0.5, height: screenHeight*0.07)
                        
                        
                        
                    }
                    .frame(width: screenWidth*0.9)
                    .padding(.leading, screenWidth*0.02)
                    
                    VStack{
                        Text("Priority Assign")
                            .fontWeight(.bold)
                            .font(.title3)
                            .frame(width: screenWidth*0.9, alignment: .leading)
                        
                        Toggle("Important", isOn: $important)
                        Toggle("Urgent", isOn: $urgent)
                        
                        
                        
                    }.frame(width: screenWidth*0.9)
                    
                    HStack{
                        Text("Priority assigned : ")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("\(priorities[priority]) Task Priority"))
                            Text(priorities[priority])
                        }.frame(width: screenWidth*0.5,height: screenHeight*0.05)
                        
                    }
                    .frame(width: screenWidth*0.9, height: screenHeight*0.1)
                    .padding(.top, screenHeight*0.01)
                    
                    HStack{
                        Text("Notifications Frequency").font(.title3).fontWeight(.semibold)
                        Spacer()
                        Picker("", selection: $selectedNotFreq) {
                            ForEach(NotFrequencies, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    .frame(width: screenWidth*0.9, alignment: .centerLastTextBaseline)
                    .padding(.top, screenWidth*0.05)
                    
                    Spacer()
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }){
                            ZStack{
                                RoundedRectangle(cornerRadius: 15).fill(.red)
                                Text("Cancel")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }.frame(width: screenWidth*0.45, height: screenHeight*0.07)
                        }
                        
                        Button(action: createTask){
                            ZStack{
                                RoundedRectangle(cornerRadius: 15).fill(.blue)
                                Text("Create Task")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }.frame(width: screenWidth*0.45, height: screenHeight*0.07)
                        }
                    }
                    .frame(width: screenWidth*0.9)
                    
                    
                }
                .onChange (of: important, perform: { newValue in
                    if important && urgent {
                        priority = 3
                    }
                    if important && !urgent {
                        priority = 2
                        
                    }
                    if !important && urgent {
                        priority = 1
                    }
                    if !important && !urgent {
                        priority = 0
                    }
                }
                )
                .onChange (of: urgent, perform: { newValue in
                    if important && urgent {
                        priority = 3
                    }
                    if important && !urgent {
                        priority = 2
                    }
                    if !important && urgent {
                        priority = 1}
                    
                    if !important && !urgent {
                        priority = 0}
                    
                })
                .frame(width: screenWidth, height: screenHeight*0.9, alignment: .top)
                .background(Color("Modal BG"))
                
            }
            .scrollDisabled(true)
            }
        
        }
    
    
    func createTask(){
        var creationPriority = 0
        switch [important,urgent] {
        case [true, true]:
            creationPriority=3
        case [true, false]:
            creationPriority=2
        case [false, true]:
            creationPriority=1
        case [false, false]:
            creationPriority=0
        default:
            creationPriority=0
        }
        
        let newTask = Task(context: moc)
        newTask.id = UUID()
        newTask.taskName = modalTaskName
        newTask.deadline = wantsDeadline ? selectedDate : nil
        newTask.priority = Int16(creationPriority)
        
        try? moc.save()

        presentationMode.wrappedValue.dismiss()
    }
}
//aggiungi titolo, modifica rettangolino priorità, aggiungi le notifiche
