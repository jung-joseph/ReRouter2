//
//  SettingsView.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/23/23.
//

import SwiftUI
import MapKit
import Observation

struct SettingsView: View {
    //    var settings = Settings()
    
    
    @Binding var showSettingsView: Bool
    @Binding var selectedMapOption: MapOptions
    @Binding var colorScheme: ColorSchemeOptions
    @Binding var transportationType: TransportationOptions
    @Bindable var distanceFormatter: DistanceFormatter
    
//    @State var units: DistanceUnit = .miles
    
    var body: some View {
        
        HStack(alignment: .top){
            Spacer()
            Spacer()
            VStack(alignment: .leading){
//                Spacer(minLength: 60)
                Text("Settings")
                    .font(.largeTitle)

                
                //            Text("distanceUnit: \(settings.distanceUnit.rawValue)")
                
                //            HStack{
                //                Text("Distance Units")
                //
                //                Picker("", selection: settings.distanceUnit){
                //                    ForEach(DistanceUnit.allCases, id: \.self) { distance in
                //                        Text(distance.title)
                //
                //                    }
                //                }
                //            }
                HStack{
                    Text("Color Scheme")
                    Picker("", selection: $colorScheme){
                        ForEach(ColorSchemeOptions.allCases) { scheme in
                            Text(scheme.rawValue).tag(scheme)
                        }
                    }
                }
                HStack{
                    Text("Map Type")
                    Picker("", selection: $selectedMapOption){
                        ForEach(MapOptions.allCases) { mapOption in
                            Text(mapOption.rawValue.capitalized).tag(mapOption)
                        }
                    }
                }
                HStack{
                    Text("Travel Mode")
                    Picker("", selection: $transportationType){
                        ForEach(TransportationOptions.allCases) { travelOption in
                            Text(travelOption.rawValue.capitalized).tag(travelOption)
                        }
                    }
                }
                HStack{
                    Text("Distance Units")
                    Picker("", selection: $distanceFormatter.unitOptions){
                        ForEach(DistanceUnit.allCases) {unit in
                            Text(unit.rawValue.capitalized).tag(unit)
                        }
                    }
                }
                Spacer()
            }
            Spacer()
            Image(systemName: "xmark.circle.fill")
                .padding([.trailing], 10)
                .onTapGesture {
                    showSettingsView = false
                }
        }.padding()
            .frame(minWidth:400, minHeight: 400)
//            .navigationTitle("Settings")
        
        
    }
}

//#Preview {
//    SettingsView()
//}
