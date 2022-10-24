//
//  detailsView.swift
//  ike
//
//  Created by Gaetano Celentano on 22/10/22.
//

import SwiftUI

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




struct detailsView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    
    @State var task : Task
    
    
    
    @State var important = false
    @State var urgent = false
    
    
    @State var selectedDate = Date()
    @State var selectedNotFreq = "Every Day"
    
    @State var NotificaionChoosing = false
    
   
    
    var body: some View {
        VStack{
            HStack{
                Text("Task Details")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .frame(width: screenWidth, alignment: .leading)
            .padding(.leading,screenWidth*0.07)
           
            
            HStack{
                TextField("Task Name", text: $task.taskName )
                Button(action:{
                    task.taskName = ""
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
                Text("DeadLine").font(.title3).fontWeight(.semibold)
                Spacer()
                HStack{
                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    Image(systemName: "calendar").imageScale(.large)
                    
                }
                .frame(width: screenWidth*0.5, height: screenHeight*0.05)
                .padding()
                
                
                
            }
            .frame(width: screenWidth*0.9, height: screenHeight*0.1)
            .padding(EdgeInsets(top: 0, leading: screenWidth*0.06, bottom: 0, trailing: screenWidth*0.07))
            
            HStack{
                Text("Current Priority").font(.title2).fontWeight(.semibold)
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 20).fill(Color("\(priorities[self.task.priority]) Task Priority"))
                    Text(priorities[self.task.priority])
                }
                    
            }
            .frame(width: screenWidth*0.9, height: screenHeight*0.05)
            .padding(.top, screenHeight*0.03)
            
            // important && urgent -> Do It
            // important && !urgent -> Schedule It
            // !important && urgent -> Delegate It
            // !important && !urgent -> Delete It
            VStack{
                Toggle("Important", isOn: $important)
                    .padding(EdgeInsets(top: 0, leading: screenWidth*0.05, bottom: 0, trailing: screenWidth*0.05))
                Toggle("Urgent", isOn: $urgent)
                    .padding(EdgeInsets(top: 0, leading: screenWidth*0.05, bottom: 0, trailing: screenWidth*0.05))
                
            }
            .frame(width: screenWidth*0.9, height: screenHeight*0.15)
            
            
            
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
            
            Button(action: saveChanges){
                ZStack{
                    RoundedRectangle(cornerRadius: 15).fill(.blue)
                    Text("Save Changes")
                        .font(.title2)
                        .foregroundColor(.white)
                }.frame(width: screenWidth*0.5, height: screenHeight*0.07)
            }
            
            

            
        }
        .frame(width: screenWidth, alignment: .top)
        .background(Color("BG"))
        .onChange(of: important, perform: { newValue in
            
            if important && urgent {
                task.priority = 3
            }
            if important && !urgent {
                task.priority = 2
            }
            if !important && urgent {
                task.priority = 1
            }
            if !important && !urgent {
                task.priority = 0
            }
        })
        .onChange(of: urgent, perform: { newValue in
            if important && urgent {
                task.priority = 3
            }
            if important && !urgent {
                task.priority = 2
            }
            if !important && urgent {
                task.priority = 1
            }
            if !important && !urgent {
                task.priority = 0
            }
        })
        .onChange(of: selectedDate, perform: { newValue in
           
            task.deadline = newValue
            
        })
        .onAppear{
          /*  let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.mm.yyyy"
            dateFormatter.dateStyle = .short*/
            
            selectedDate = task.deadline
            
            switch task.priority {
            case 3:
                important = true
                urgent = true
            case 2:
                important = true
                urgent = false
            case 1:
                important = false
                urgent = true
            case 0:
                important = false
                urgent = false
            default:
                important = false
                urgent = false
            }
        }
        
    }
    
    
    
    func saveChanges(){
        
    }
    
    
}


