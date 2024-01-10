//
//  FavoritesScreen.swift
//  ReRouter2
//
//  Created by Joseph Jung on 1/8/24.
//

import SwiftUI
import MapKit

struct FavoritesScreen: View {
    
    @Binding var selectedMapItem: MKMapItem?
    @Binding var favoriteMapItems: [MKMapItem]
    @Bindable var distanceFormatter: DistanceFormatter
    @Binding var showFavoritesView: Bool
    @Binding var displayMode: DisplayMode

    
    var body: some View {
        VStack{
            switch displayMode {
            case .list:
                
                FavoritesListView(selectedMapItem: $selectedMapItem, favoriteMapItems: $favoriteMapItems, distanceFormatter: distanceFormatter, showFavoritesView: $showFavoritesView, displayMode: $displayMode)
                
            case .detail:
                
                SelectedPlaceDetailView(mapItem: $selectedMapItem, distanceFormatter: distanceFormatter, showSearchView: $showFavoritesView)
                    .padding()
                
            }
            
        }
    }
}

//#Preview {
//    FavoritesScreen()
//}
