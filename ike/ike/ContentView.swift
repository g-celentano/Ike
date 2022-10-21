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
                   Text("+").font(.system(size: 36))
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: screenWidth*0.05))
            }
            .frame(width: screenWidth, alignment: .trailing)
            .padding(EdgeInsets(top: screenHeight*0.05, leading: 0, bottom: 0, trailing: 0))
            
            
            
            //space reserved for the pie chart------------------------------------------------------
            ZStack{
                
            }
            .frame(width: screenWidth*0.65,height: screenWidth*0.65)
            .background(.red)
            
            
            //space for the priority switch------------------------------------------------------
            HStack{
                OrderChoices()
            }
            .frame(width: screenWidth*0.9)

            // space for the task list------------------------------------------------------
            VStack{
                TaskList()
                    .cornerRadius(10)
            }
            .frame(width: screenWidth*0.9)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: screenHeight*0.05, trailing: 0))
            
            
            
        }
        .frame(width: screenWidth, height: screenHeight, alignment: .top)
        
            
       
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
