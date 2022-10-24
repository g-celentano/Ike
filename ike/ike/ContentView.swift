//
//  ContentView.swift
//  ike
//
//  Created by Gaetano Celentano on 19/10/22.
//

import SwiftUI
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height


struct ContentView: View {
    //getting the screen boundaries for sizing and placing
   
    @State private var isPresented = false
    
    var body: some View {
        
        
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
                
                .fullScreenCover(isPresented: $isPresented, content: FullScreenModalView.init)
          
            
            /*   Button(action: {}) {
             //Text("+").font(.system(size: 36))
             Image(systemName: "plus").imageScale(.large)
             }
             .padding(.trailing, screenWidth*0.05)*/
        }
        .frame(width: screenWidth, alignment: .trailing)
        .padding(.top, screenHeight*0.05)
        
        
        
        //space reserved for the pie chart------------------------------------------------------
        ZStack{
            
        }
        .frame(width: screenWidth * 0.65,height: screenWidth * 0.65)
        .background(.red)
        
        
        //space for the priority switch------------------------------------------------------
        HStack{
            OrderChoices()
        }
        .frame(width: screenWidth*0.9)
        
        // space for the task list------------------------------------------------------
        VStack{
            TaskList()
                .background(.red)
                .cornerRadius(10)
            
            
        }
        .frame(width: screenWidth*0.9)
        .padding(.bottom, screenHeight*0.05)
        
        
        
        
    }
        .frame(width: screenWidth, height: screenHeight, alignment: .top)
        .background(Color("BG"))
        
            
       
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Taskini: View{
    var task: Task
    var body: some View{
        Text("\(task.taskName)")
    }
}

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode

    
    @State var task_modal = ""
    @State var expire = ""
    @State private var urgent = false
    @State private var important = false
    @State var priority = 0
    
    let priorities = [
    "Delete It",
    "Delegate It",
    "Schedule It",
    "Do It"
    ]
    
    var body: some View {
        ZStack{
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
                    }.frame(width: screenWidth, alignment: Alignment.trailing)
                    
                    Text("Add New Task")
                        .fontWeight(.bold)
                        .padding(.leading, screenWidth*(-0.32))
                        .font(.largeTitle)
                    
                    
                    TextField("Task name", text: $task_modal)
                    
                        .submitLabel(.join)
                        .foregroundColor(.black)
                        .padding()
                        .font(.title)
                    
                    
                    HStack{
                        
                        Text("Deadline")
                            .padding(.horizontal)
                        
                        TextField("MM/DD/YYYY", text: $expire)
                        
                            .submitLabel(.join)
                            .foregroundColor(.black)
                            .padding(.horizontal, screenWidth*0.25)
                        
                        
                    }
                    .padding(.top, 12)
                    
                    Text("Priority Assign")
                        .fontWeight(.bold)
                        .padding(.horizontal, -180.0)
                        .padding(.top, 24)
                        .font(.title2)
                    
                    
                    VStack{
                        Toggle("Urgent", isOn: $urgent)
                            .font(.body)
                            .padding(.leading)
                            .padding (.top, 8)
                            .padding(.horizontal)
                        Toggle("Important", isOn: $important)
                            .padding(.leading)
                            .padding(.horizontal)
                    }
                    
                    HStack{
                        Text("Priority assigned : ").font(.headline).fontWeight(.semibold)
                            .padding(.leading, screenWidth*0.02)
                        ZStack{
                            
                                RoundedRectangle(cornerRadius: 20).fill(Color("\(priorities[priority]) Task Priority"))
                            Text(priorities[priority])
                        }.frame(width: screenWidth*0.50, height: screenHeight*0.06)
                    }
                    HStack{
                        Text("Notification Frequency")
                    }
                    
                    Spacer()
                    HStack{
                        Button{
                            
                        }label:{
                            Text("Cancel")
                        }
                        
                        .foregroundColor(.red)
                        .padding(.horizontal, screenWidth*0.16)
                        .contentShape(Rectangle())
                        
                        Button{
                            
                        }label:{
                            Text("Create New Task")
                        }
                        
                        .foregroundColor(.blue)
                        .padding(.horizontal, screenWidth*0.16)
                        .contentShape(Rectangle())
                    }
                    
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
                .frame(alignment: .top)
                .background(Color("Modal BG"))
            }
        }
}
//aggiungi titolo, modifica rettangolino priorità, aggiungi le notifiche
