//
//  ContentView.swift
//  ike
//
//  Created by Gaetano Celentano on 19/10/22.
//

import SwiftUI

struct ContentView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "plus")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            .frame(width: screenWidth,
                   alignment: .trailing)
           
        }
       
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
