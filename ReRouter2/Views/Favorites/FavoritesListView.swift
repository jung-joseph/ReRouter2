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
    @Binding var finalDestination: MKMapItem?
    @Binding var waypointDestination: MKMapItem?
    @Bindable var distanceFormatter: DistanceFormatter
    @Binding var showFavoritesView: Bool
    @Binding var displayMode: DisplayMode
    
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        
        VStack{
            Spacer()
            
            VStack{
                HStack{
                    Spacer()
                    Spacer()
                    Button {
                        favoriteMapItems.removeAll()
                        selectedMapItem = nil
                        writeArrayUserDefaults(arrayIn: favoriteMapItems, mapItem: selectedMapItem)
                        
                    } label: {
                        Image(systemName: "trash")
                        Text("Delete All").font(.system(size: 10))
                    }
                }
                NavigationView{
                    List(selection: $selectedMapItem){
                        ForEach(favoriteMapItems, id: \.self) { mapItem in
                            VStack{
                                PlaceView(mapItem: mapItem, distanceFormatter: distanceFormatter, showSearchView: $showFavoritesView)
                                HStack{
                                    Button {
                                        finalDestination = selectedMapItem
                                    } label: {
                                        Text("Set as Final Destination")
                                            .font(.system(size: 10))
                                    }

                                    Button {
                                        waypointDestination = selectedMapItem
                                    } label: {
                                        Text("Set as Waypoint Destination")
                                            .font(.system(size: 10))
                                    }

                                }.buttonStyle(.borderedProminent)
                                    .tint(Color(red: 236/255, green: 240/255, blue: 241/255, opacity: 1.0))
                                    .foregroundColor(.black)
                                    .padding(4)
                            }
                        }
                        .onDelete{indexSet in
                            favoriteMapItems.remove(atOffsets: indexSet)
                            writeArrayUserDefaults(arrayIn: favoriteMapItems, mapItem: selectedMapItem)
                        }
                    }
                    .task(id: selectedMapItem){
                        
                    }
                    .navigationTitle(Text("Favorites"))
                    .navigationBarItems(leading: EditButton())
                    .environment(\.editMode, $editMode)
                    
                }
            }
            
        }
        
    }
    
    
}

//#Preview {
//    FavoritesListView()
//}
