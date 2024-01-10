//
//  FavoritesListView.swift
//  ReRouter2
//
//  Created by Joseph Jung on 1/7/24.
//

import SwiftUI
import MapKit

struct FavoritesListView: View {
    
    @Binding var selectedMapItem: MKMapItem?
    @Binding var favoriteMapItems: [MKMapItem]
    @Bindable var distanceFormatter: DistanceFormatter
    @Binding var showFavoritesListView: Bool
    
    var body: some View {
        
        VStack{
            Text("Favorites")
            
           
            List(favoriteMapItems, id: \.self, selection: $selectedMapItem) { mapItem in
                
                PlaceView(mapItem: mapItem, distanceFormatter: distanceFormatter, showSearchView: $showFavoritesListView)
            }

        }
            
}
    
    
}

//#Preview {
//    FavoritesListView()
//}
