//
//  RouteView.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/20/23.
//

import SwiftUI
import MapKit
import Observation

struct RouteView: View {
    
    @Binding var showRouteView: Bool
    var route: MKRoute?
    @Binding var destination: MKMapItem?
    @Binding var transportationType: TransportationOptions
    @Bindable var distanceFormatter: DistanceFormatter
        
    let travelMode: [Int:String] = [1:"Automobile", 2:"Walking", 3:"Transit"]

    var body: some View {
        HStack(alignment: .top){
            Spacer()
            Spacer()
            VStack(alignment: .leading){
                Spacer(minLength: 60)
                Text("Routing Directions")
                    .font(.largeTitle)
                Text("Destination: \(destination?.name ?? "None")")
                Text("Transportation Type: \(travelMode[Int(transportationType.transportationOption.rawValue)]!)")
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading){
                        if route != nil {
                            ForEach(route!.steps, id: \.self) { step in
                                HStack{
                                    let stepInstructions = step.instructions
                                    let iconName = self.directionsIcon(stepInstructions)
                                    let formattedDistance = "\(distanceFormatter.format(distanceInMeters: step.distance))"
                                    Image(systemName: iconName)
                                    Text(formattedDistance)
                                    Text(step.instructions)
                                }
                            }
                        } else {
                            Spacer(minLength: 50)
                            Text("No Active Routes")
                        }
                    }
                }
            }
            Spacer()
            Image(systemName: "xmark.circle.fill")
                .padding([.trailing], 10)
                .onTapGesture {
                    showRouteView = false
                }
            
        }
    }
    private func directionsIcon(_ instruction: String) -> String {
        if instruction.contains("Turn right"){
            return "arrow.turn.up.right"
        } else if instruction.contains("Turn left") {
            return "arrow.turn.up.left"
        } else if instruction.contains("destination") {
            return "mappin.circle.fill"
        } else {
            return "arrow.up"
        }
    }
    
}
//#Preview {
//    RouteView()
//}
