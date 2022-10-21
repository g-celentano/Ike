//
//  ContentView.swift
//  ike
//
//  Created by Gaetano Celentano on 19/10/22.
//

import SwiftUI

struct ContentView: View {
    //getting the screen boundaries for sizing and placing
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    
    var body: some View {
        VStack {
            // horizontal stack for the actions------------------------------------------------------
            HStack{
                Button(action: {}) {
                   //Text("+").font(.system(size: 36))
                    Image(systemName: "plus").imageScale(.large)
                }
                .padding(.trailing, screenWidth*0.05)
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
