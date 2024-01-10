//
//  SearchBarView.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/20/23.
//

import SwiftUI
import MapKit

struct SearchBarView: View {
    
    @Binding var search: String
    @Binding var isSearching: Bool
    
    @Binding var selectedMapItem: MKMapItem?
    @Binding var favoriteMapItems: [MKMapItem]
    @Binding var finalDestination: MKMapItem?
    @Binding var waypointDestination: MKMapItem?

    
    @Bindable var distanceFormatter: DistanceFormatter
    @Binding var displayMode: DisplayMode

    
    var body: some View {
        VStack(spacing: -10) {
            TextField("Search", text: $search)
                .textFieldStyle(.roundedBorder)
                .padding()
                .onSubmit {
                    isSearching = true
                }
            SearchOptionsView(selectedMapItem: $selectedMapItem, favoriteMapItems: $favoriteMapItems, finalDestination: $finalDestination, waypointDestination: $waypointDestination, distanceFormatter: distanceFormatter, displayMode: $displayMode){ searchOption in
                search = searchOption
                isSearching = true
            }
            .padding([.leading], 10)
            .padding([.bottom], 20)
        }
    }
}

//#Preview {
//    SearchBarView(search: .constant("Coffee"), isSearching: .constant(true))
//}
