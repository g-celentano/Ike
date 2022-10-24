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
    
    var body: some View {
        
        NavigationView{
         
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode

    
    @State var task_modal = ""
    @State var expire = ""
    @State private var urgent = false
    @State private var important = false
    @State var priority = 0
    @State var selectedDate = Date()
    @State var selectedNotFreq="Every Day"
    

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
                    
                    
                    HStack{
                        TextField("Task Name", text: $task_modal ).font(.title3)
                        Button(action:{
                            task_modal = ""
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
                        
                        Text("Deadline")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        HStack{
                            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            Image(systemName: "calendar").imageScale(.large)
                            
                        }
                        .frame(width: screenWidth*0.5, height: screenHeight*0.05)
                        .padding()
                        
                        
                    }.frame(width: screenWidth*0.9)
                    
                    VStack{
                        Text("Priority Assign")
                            .fontWeight(.bold)
                            .font(.title3)
                            .frame(width: screenWidth*0.9, alignment: .leading)
                        
                        Toggle("Important", isOn: $important)
                        Toggle("Urgent", isOn: $urgent)
                        
                        
                           
                    }.frame(width: screenWidth*0.9)
                    
                    HStack{
                        Text("Priority assigned : ").font(.title3).fontWeight(.semibold)
                        Spacer()
                        ZStack{
                                RoundedRectangle(cornerRadius: 20).fill(Color("\(priorities[priority]) Task Priority"))
                            Text(priorities[priority])
                        }.frame(width: screenWidth*0.55, height: screenHeight*0.06)
                    }.frame(width: screenWidth*0.9)
                   
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
                        Button(action: cancelAction){
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
                    }.frame(width: screenWidth*0.9)
                    
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
                .frame(width: screenWidth, alignment: .top)
                .background(Color("Modal BG"))
            }
        }
    
    func cancelAction(){
        
    }
    func createTask(){
        
    }
}
//aggiungi titolo, modifica rettangolino priorità, aggiungi le notifiche
