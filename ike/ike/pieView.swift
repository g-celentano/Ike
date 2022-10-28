//
//  ContentView.swift
//  pie
//
//  Created by Tonia D'Alessio on 24/10/22.
//

import SwiftUI

enum Assets {
    case DoIt, ScheduleIt, DelegateIt, DeleteIt
}

struct AssetsAllocation {
    let asset : Assets
    let description : String
    let color : Color
}

final class PieChartViewmodel : ObservableObject {
    @Published var data: [AssetsAllocation] =
    [
        AssetsAllocation(asset: .DoIt, description: "Delete It", color:Color ("Delete It Chart Priority")),
                                               
        AssetsAllocation(asset: .ScheduleIt, description: "Delegate It", color: Color ("Delegate It Chart Priority")),
        
        AssetsAllocation(asset: .DelegateIt, description: "Do It", color: Color ("Do It Chart Priority ")),
                                                                                           
        AssetsAllocation(asset: .DeleteIt, description: "Schedule It", color: Color("Schedule It Chart Priority"))
]
    
    
}
                                                                    

struct PieceOfPie : Shape {
    let startDegree : Double
    let endDegree : Double
    
    func path(in rect: CGRect) -> Path { Path { p in
        let center = CGPoint(x: rect.midX, y: rect.midY)
        p.move (to : center)
        p.addArc(center: center, radius: rect.width / 2, startAngle: Angle(degrees: startDegree), endAngle: Angle(degrees: endDegree), clockwise: false)
        p.closeSubpath()
        
    }
        
    }
}

struct PieChart : View {
    @ObservedObject var viewModel =  PieChartViewmodel()
    @State var selectedPieChartElement: Int? = nil
    @Binding var tasks : FetchedResults<Task>
    @Binding var highPrio : String
    
    var body : some View {
        ZStack {
            if tasks.count > 0 {
                ForEach(0..<viewModel.data.count, id: \.self) {index in
                    let currentData = viewModel.data[index]
                    let currentEndDegree = getPercentage(desc: currentData.description) * 360
                    let lastDegree = viewModel.data.prefix(index).map{getPercentage(desc: $0.description)}.reduce(0, +) * 360
                   
                    ZStack {
                        
                        PieceOfPie(startDegree: lastDegree, endDegree: lastDegree + currentEndDegree )
                                .fill(currentData.color)
                                .scaleEffect(index == selectedPieChartElement ? 1.3 : 1.0 )
                                .onTapGesture {
                                    withAnimation {
                                        if index == selectedPieChartElement {
                                            self.selectedPieChartElement = nil
                                            highPrio = ""
                                        } else {
                                            self.selectedPieChartElement = index
                                            highPrio = currentData.description
                                        }
                                    }
                                    
                                    
                                }
                        GeometryReader { geometry in
                            Text(currentData.description)
                                .font(.custom("SF Pro Text", size :screenWidth*0.035))
                                .foregroundColor(.white)
                                .position(getLabelCoordinate(in: geometry.size, for: lastDegree + (currentEndDegree / 2)))
                                .scaleEffect(index == selectedPieChartElement ? 1.3 : 1.0 )
                                .opacity(getPercentage(desc: currentData.description) < 0.1 ? 0.0 : 1.0)
                            
                        }
                    }
                   

                    
                }
            }else{
                Text("Add your first task")
                    .font(.title)
            }
            
        }
    }
    
    func getPercentage(desc : String) -> Double{
        let prioCount = tasks.filter { task in
            priorities[Int(task.priority)] == desc
        }.count
        let percentage =  Double((prioCount * 10000) / tasks.count) / 10000
        return percentage
    }
                    
    private func getLabelCoordinate (in geoSize :CGSize, for degree : Double) -> CGPoint {
        let center = CGPoint(x: geoSize.width / 2, y: geoSize.height / 2)
        let radius = geoSize.width / 4
        
        let yCoordinate =  radius * sin(CGFloat(degree) * CGFloat.pi / 180)
        
        let xCoordinate =  radius * cos(CGFloat(degree) * CGFloat.pi / 180)
        
        return CGPoint(x: center.x + xCoordinate, y: center.y + yCoordinate)
        
     }
                }

struct pieView: View {
    @State var tasks : FetchedResults<Task>
    @Binding var highPrio : String
    var body: some View {
        PieChart( tasks: $tasks, highPrio: $highPrio)
        }
    }

