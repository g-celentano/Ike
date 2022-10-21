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
                        .foregroundColor(.black)
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


struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "x.circle")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                }
                .padding(.trailing, screenWidth*0.05)
            }.frame(width: screenWidth, alignment: Alignment.trailing)
        }
        .padding(.top, screenHeight*0.02)
        .frame(height: screenHeight*0.9, alignment: .top)
            .background( Color.gray.edgesIgnoringSafeArea(.bottom).opacity(0.1))
       
    }
}
