//
//  SearchScreen.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/20/23.
//

import SwiftUI
import MapKit



struct SearchScreen: View {
    
    @Binding var locationManager: LocationManager
    @Binding var selectedMapItem: MKMapItem?
    @Binding var mapItems: [MKMapItem]
    @Binding var route: MKRoute?
    @Binding var visibleRegion: MKCoordinateRegion?
    @Binding var selectedDetents: PresentationDetent
    @Binding var displayMode: DisplayMode
    @Binding var isSearching: Bool
    @Binding var transportationType: TransportationOptions
    @Bindable var distanceFormatter: DistanceFormatter
    @Binding var destinationMapItems: [MKMapItem]
    @Binding var favoriteMapItems: [MKMapItem]
    @Binding var finalDestination: MKMapItem?
    @Binding var waypointDestination: MKMapItem?
    @Binding var showSearchView: Bool
    
    
    @State private var query: String = ""
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var snapshotImage: UIImage?
    
    

    private func snapShot() async  {
        
        let options = MKMapSnapshotter.Options()
        let size = 350.0
        options.showsBuildings = true
        options.mapType = .hybrid
        options.camera = MKMapCamera(lookingAtCenter: selectedMapItem!.placemark.coordinate, fromDistance: 500, pitch: 65, heading: 0)
        options.size = CGSize(width: size, height: size/2)
        let snapshotter = MKMapSnapshotter(options: options)
        
        snapshotImage = nil
        
        
        if let snapshot = try? await snapshotter.start() {
            snapshotImage = snapshot.image
            
        }
        
        
        
        
        /*
         // https://stackoverflow.com/questions/74949467/how-to-add-pin-annotation-view-to-mkmapsnapshotter-in-swiftui
         
         */
    }
    private func search() async {
        
        do {
            mapItems = try await performSearch(searchTerm: query, visibleRegion: visibleRegion)
            isSearching = false
        } catch {
            mapItems = []
            print(error.localizedDescription)
            isSearching = false
        }
    }
    
    var body: some View {
        VStack {
            
            switch displayMode{
            case .list:
                SearchBarView (search: $query, isSearching: $isSearching, selectedMapItem: $selectedMapItem, favoriteMapItems: $favoriteMapItems, finalDestination: $finalDestination, waypointDestination: $waypointDestination, distanceFormatter: distanceFormatter, displayMode: $displayMode)
                PlaceListView(mapItems: $mapItems, selectedMapItem: $selectedMapItem, distanceFormatter: distanceFormatter, showSearchView: $showSearchView)
            case .detail:
                SelectedPlaceDetailView(mapItem: $selectedMapItem, distanceFormatter: distanceFormatter, showSearchView: $showSearchView)
                    .padding()
                
                
                if selectedMapItem != nil {
                    ActionButtons(mapItem: $selectedMapItem, mapItems: $mapItems, favoriteMapItems: $favoriteMapItems, finalDestination: $finalDestination, waypointDestination: $waypointDestination, selectedDetents: $selectedDetents )
                        .padding()
                }
                    
                    if let lookAroundScene {
                        LookAroundPreview(initialScene: lookAroundScene)
                    } else {
                        if let snapshotImage { // if snapshotImage != nil {
                            Image(uiImage: snapshotImage)
                        }
                    }

                
            }
            
            Spacer()
        }
        .padding([.top])
        .onChange(of:selectedMapItem, {
//            print(" SearchScreen on Change")
            if selectedMapItem != nil {
                displayMode = .detail
                //                requestCalculateDirections()
            } else {
                displayMode = .list
                isSearching = false
                route = nil //  to reset the route
            }
        })
        .task(id: selectedMapItem){
//            print("Search Screen selectedMapItem task")
            lookAroundScene = nil
            if let selectedMapItem {
                
                let request = MKLookAroundSceneRequest(mapItem: selectedMapItem)
                lookAroundScene = try? await request.scene
                
                if lookAroundScene == nil {
                    await snapShot()
                }
                var duplicateMapItem = false
//                print("SearchScreen selectedMapItem \(selectedMapItem.name ?? "nil")")
                checkLoop: for item in destinationMapItems{
//                    print("\(String(describing: item.name))  \("selectedMapItem.name")")
                    if item.name == selectedMapItem.name{
//                        print("SearchScreen MapItem in destinationMapIems \(item.name ?? "nil")")
                        duplicateMapItem = true
                    }
                    if duplicateMapItem{
//                        print("Breaking")
                        break checkLoop
                    }
                }
                
                if !duplicateMapItem {
                    // save to destinationMapItem array (use as Recent Destinations)
//                    print("Appending selectedMapItem")
                    destinationMapItems.append(selectedMapItem)
                }
                
                await route = requestCalculateDirections(selectedMapItem: selectedMapItem, locationManager: locationManager, transportationType: transportationType)
            }

            
        }
//        .task(id: selectedDestinationMapItem) {
//            print("selectedDestinationMapItem not nil")
//            await route = requestCalculateDirections(selectedMapItem: selectedDestinationMapItem, locationManager: locationManager, transportationType: transportationType)
//            
//        }
        .task(id:isSearching, {
            if isSearching {
                route = nil
                await search()
            }
        })
    }
}

//#Preview {
//    SearchScreen()
//}
