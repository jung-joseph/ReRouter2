//
//  DestinationsView.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/20/23.
//

import SwiftUI
import MapKit

struct DestinationsView: View {
    
    @Binding var showDestinationsView: Bool
    @Binding var mapItems: [MKMapItem]
    @Binding var selectedMapItem: MKMapItem?
    @Binding var destinationMapItems: [MKMapItem]
    @Bindable var distanceFormatter: DistanceFormatter
    @Binding var locationManager: LocationManager
    @Binding var transportationType: TransportationOptions
    @Binding var route: MKRoute?
    @Binding var showSearchView: Bool
    
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        
        HStack(alignment: .top) {
            Spacer()
            Spacer()
            VStack(alignment: .leading){
                Spacer(minLength: 60)
                Text("Recent Destinations")
                    .font(.largeTitle)
                
                //                List(destinationMapItems, id: \.self, selection: $selectedDestinationMapItem) { mapItem in
                //                    PlaceView(mapItem: mapItem, distanceFormatter: distanceFormatter)
                //                }
                NavigationView {
                    List(selection: $selectedMapItem) {
                        ForEach(destinationMapItems, id: \.self) { mapItem in
                            PlaceView(mapItem: mapItem, distanceFormatter: distanceFormatter, showSearchView: $showSearchView)
                        }
                        .onDelete{ indexSet in
                            destinationMapItems.remove(atOffsets: indexSet)
                        }
                        .task(id: selectedMapItem){
                            mapItems.removeAll()
                            if selectedMapItem != nil {
//                                Marker(item: selectedDestinationMapItem!)
                                await route = requestCalculateDirections(selectedMapItem: selectedMapItem, locationManager: locationManager, transportationType: transportationType)
                                //                showSearchView = true
                                print("IN .task destinationView")
                            }
                        }
                    }
                    .navigationBarItems(leading: EditButton())
                    .environment(\.editMode, $editMode)
                }
            }
            
            
            Spacer()
            Image(systemName: "xmark.circle.fill")
                .padding([.trailing], 10)
                .onTapGesture {
                    showDestinationsView = false
                }
        }
    }
    
    
}

//#Preview {
//    DestinationsView()
//}
