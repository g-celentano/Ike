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

@main
struct ikeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

}
