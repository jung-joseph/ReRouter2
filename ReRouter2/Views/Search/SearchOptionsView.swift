//
//  SearchOptionsView.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/20/23.
//

import SwiftUI
import MapKit

struct SearchCategory: Hashable {
    var searchTerm: String = ""
    var searchSymbol: String = ""
}

struct SearchOptionsView: View {
    
    @State var showFavoritesView = false
    
    @Binding var selectedMapItem: MKMapItem?
    @Binding var favoriteMapItems: [MKMapItem]
    @Binding var finalDestination: MKMapItem?
    @Binding var waypointDestination: MKMapItem?

    @Bindable var distanceFormatter: DistanceFormatter
    @Binding var displayMode: DisplayMode
    
    let searchOptions = ["Dog Parks": "dog.fill", "Restaurants": "fork.knife", "Hotels": "bed.double.fill", "Coffee": "cup.and.saucer.fill", "Gas": "fuelpump.fill", "Historical Sites": "books.vertical.fill"]

    
    let searchCategories = [
        SearchCategory(searchTerm: "DogParks", searchSymbol: "dog.fill"),
        SearchCategory(searchTerm: "Coffee", searchSymbol: "cup.and.saucer.fill"),
        SearchCategory(searchTerm: "Restaurants", searchSymbol: "fork.knife"),
        SearchCategory(searchTerm: "Hotels", searchSymbol: "bed.double.fill"),
        SearchCategory(searchTerm: "Gas", searchSymbol: "fuelpump.fill"),
        SearchCategory(searchTerm: "EV Chargers", searchSymbol: "ev.charger.fill"),
        SearchCategory(searchTerm: "Tesla Chargers", searchSymbol: "ev.charger.fill"),
        SearchCategory(searchTerm: "Historical Sites", searchSymbol: "books.vertical.fill"),
        SearchCategory(searchTerm: "Emergency Room", searchSymbol: "cross.case.fill")
    ]
    
    let onSelected: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false)  {
            HStack {
                
                Button(action: {
                    showFavoritesView = true
                    // get the current savedFavorites
                    
                    
                    print("in FavoritesListView - onSubmit")
                    /*
                    do {
                        if let data = UserDefaults.standard.data(forKey: "savedMapItems") {
                            if let tempFavoriteMapItems = try NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: MKMapItem.self, from: data){
                                
                                favoriteMapItems.removeAll()

                                tempFavoriteMapItems.forEach { item in
                                    print("mapItem Name: \(String(describing: item.name))")
                                    favoriteMapItems.append(item)
                                }
                            }
                        }
                        
                    } catch {
                        print("try failed")
                    }
                    */
                    
                    
                    if let readFavoriteMapItems = readArrayUserDefaults(arrayIn: favoriteMapItems){
                        favoriteMapItems.removeAll()
                        print("appending old favoriteMapItems")
                        readFavoriteMapItems.forEach() { item in
                            print("mapItem Name: \(String(describing: item.name))")
                            favoriteMapItems.append(item)
                        }
                    }
                        
                }, label: {
                    HStack {
                        Image(systemName: "star.fill")
                        Text("Favorites")
                           
                    }
                })
                .sheet(isPresented: $showFavoritesView) {
                    FavoritesScreen(selectedMapItem: $selectedMapItem, favoriteMapItems: $favoriteMapItems, finalDestination: $finalDestination, waypointDestination: $waypointDestination, distanceFormatter: distanceFormatter, showFavoritesView: $showFavoritesView, displayMode: $displayMode)
                        .presentationDragIndicator(.visible)
                }
                
                ForEach(searchCategories, id: \.self) {category in
                    Button(action: {
                        // action
                        onSelected(category.searchTerm)
                    }, label: {
                        HStack {
                            Image(systemName: category.searchSymbol)
                            Text(category.searchTerm)
                        }
                    })
                    
                }
            }.buttonStyle(.borderedProminent)
                .tint(Color(red: 236/255, green: 240/255, blue: 241/255, opacity: 1.0))
                .foregroundColor(.black)
                .padding(4)
        }
        HStack{
            Button {
                finalDestination = nil
                waypointDestination = nil
            } label: {
                Text("Clear All Destinations")
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 236/255, green: 240/255, blue: 241/255, opacity: 1.0))
            .foregroundColor(.black)
            .padding(4)
            
            Button {
                finalDestination = nil
            } label: {
                Text("Clear Final Destination")
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 236/255, green: 240/255, blue: 241/255, opacity: 1.0))
            .foregroundColor(.black)
            .padding(4)
            
            Button {
                waypointDestination = nil
            } label: {
                Text("Clear Waypoint Destination")
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 236/255, green: 240/255, blue: 241/255, opacity: 1.0))
            .foregroundColor(.black)
            .padding(4)
        }
    }
}

//#Preview {
//    SearchOptionsView(onSelected: { _ in })
//}
