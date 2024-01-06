//
//  SelectedPlaceDetailView.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/20/23.
//

import SwiftUI
import MapKit

struct SelectedPlaceDetailView: View {
    
    @Binding var mapItem: MKMapItem?
    @Bindable var distanceFormatter: DistanceFormatter
    @Binding var showSearchView: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading){
//                Text("Selected Place Detail")
                Text("")

                    .font(.title)
                if let mapItem {
                    PlaceView(mapItem: mapItem, distanceFormatter: distanceFormatter, showSearchView: $showSearchView)
                }
            }
            
            Image(systemName: "xmark.circle.fill")
                .padding([.trailing], 10)
                .onTapGesture {
                    mapItem = nil
                }
        }
    }
}

//#Preview {
//    let apple = Binding<MKMapItem?>(
//        get: { PreviewData.apple },
//        set: { _ in}
//    )
//    return SelectedPlaceDetailView(mapItem: apple)
//}
