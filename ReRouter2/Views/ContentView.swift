//
//  ContentView.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/19/23.
//

import SwiftUI
import MapKit
import Observation

/*
 home coordinates: lat: 35.164632 ; lon: -106.511915
 Charlettesville VA: lat: 38.0293 ; lon: -78.4767
 Hudson OH: lat: 41.2401 ; lon: -81.4407
 */

enum DisplayMode{
    case list
    case detail
}

struct ContentView: View {
    @State var locationManager = LocationManager.shared
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State var mapItems: [MKMapItem] = []
    @State var selectedMapItem: MKMapItem?
    @State var route: MKRoute?
    @State var visibleRegion: MKCoordinateRegion?
    @State var destinationMapItems: [MKMapItem] = []
    @State var finalDestination: MKMapItem?
    @State var waypointDestination: MKMapItem?
    
    @State var favoriteMapItems: [MKMapItem] = []
    
    @State var selectedMapOption: MapOptions = .standard
    @State var colorScheme: ColorSchemeOptions = .light
    @State var transportationType: TransportationOptions = .automobile
    @Bindable var distanceFormatter = DistanceFormatter()

    
    @State private var showSearchView: Bool = false
    @State private var showDestinationsView: Bool = false
    @State private var showRouteView: Bool = false
    @State private var showSettingsView: Bool = false
    @State var selectedDetents: PresentationDetent = .fraction(0.0)

    @State var displayMode: DisplayMode = .list
    @State var isSearching: Bool = false
    
    let toolbarColor = Color(.black)
    
    func routeIconColor(route: MKRoute?) -> Color {
        if route != nil {
            return Color(.red)
        } else {
            return toolbarColor
        }
    }
    
    var body: some View {
        //        let tabColor = Color(.black)
        
        NavigationView {
            ZStack(alignment: .topLeading) {
                
                Map(position: $position, selection: $selectedMapItem) {
                    if let selectedMapItem {
                        Marker(item: selectedMapItem)
                    } else {
                        ForEach(mapItems, id: \.self) { mapItem in
                            Marker(item: mapItem)
                        }
                    }
                    //                if let selectedDestinationMapItem {
                    //
                    //                    Marker(item: selectedDestinationMapItem)
                    //                }
                    if let route {
                        MapPolyline(route)
                            .stroke(.blue, lineWidth: 5)
                    }
                    UserAnnotation()
                }
                .mapStyle(selectedMapOption.mapStyle)
                .mapControls {
                    MapUserLocationButton()
                }
                .onChange(of:selectedMapItem, {
                    if selectedMapItem != nil {
                        //                    print("ContentView on change of selectedMapItem")
                        displayMode = .detail
                        //                    if showSearchView == true{
                        showSearchView = true
                        selectedDetents = .fraction(0.15)
                        //                    }
                    } else {
                        displayMode = .list
                        isSearching = false
                        route = nil
                    }
                })
                
                
                .onChange(of: locationManager.region, {
                    position = .region(locationManager.region)
                })
                .onMapCameraChange { context in
                    visibleRegion = context.region
                }
                .task(id: selectedMapItem){
                    await route = requestCalculateDirections(selectedMapItem: selectedMapItem, locationManager: locationManager, transportationType: transportationType)
                    //                showSearchView = true
                    //                print("ContentView in .task selectedMapItem")
                }
                .toolbar{
                    ToolbarItemGroup(placement: .bottomBar) {
                        HStack{
                            Spacer()
                            // MARK: - Search
                            Button{
                                showSearchView = true
                            } label: {
                                VStack{
                                    Image(systemName: "magnifyingglass.circle.fill").foregroundColor(toolbarColor)
                                    Text("Search")
                                        .font(.caption2)
                                        .foregroundColor(toolbarColor)
                                }
                            }
                            .padding([.leading])
                            .sheet(isPresented: $showSearchView) {
                                SearchScreen(locationManager: $locationManager, selectedMapItem: $selectedMapItem, mapItems: $mapItems, route: $route, visibleRegion: $visibleRegion, selectedDetents: $selectedDetents, displayMode: $displayMode, isSearching: $isSearching, transportationType: $transportationType, distanceFormatter: distanceFormatter, destinationMapItems: $destinationMapItems, favoriteMapItems: $favoriteMapItems,finalDestination: $finalDestination, waypointDestination: $waypointDestination,showSearchView: $showSearchView)
                                //                                .presentationDetents([.fraction(0.25), .medium,.large])
                                    .presentationDetents([.fraction(0.35), .medium,.large], selection: $selectedDetents)
                                
                                //                                .presentationDragIndicator(.visible)
                            }
                            .onChange(of: selectedMapItem){
                                selectedDetents = .fraction(0.9)
                            }
                            
                            // MARK: - Destinations
                            
                            Button{
                                showDestinationsView = true
                            } label: {
                                VStack{
                                    Image(systemName: "mappin.and.ellipse").foregroundColor(toolbarColor)
                                    Text("Recent Destinations")
                                        .font(.caption2)
                                        .foregroundColor(toolbarColor)
                                }
                            }
                            .sheet(isPresented: $showDestinationsView) {
                                DestinationsView(showDestinationsView: $showDestinationsView, mapItems: $mapItems,selectedMapItem: $selectedMapItem, destinationMapItems: $destinationMapItems, distanceFormatter: distanceFormatter, locationManager: $locationManager, transportationType: $transportationType, route: $route, showSearchView: $showSearchView)
                                    .presentationDetents([.fraction(0.50),.fraction(0.75),.large])
                            }
                            
                            padding([.leading, .trailing])
                            
                            // MARK: - Route
                            
                            Button{
                                showRouteView = true
                            } label: {
                                VStack{
                                    Image(systemName: "point.topleft.down.curvedto.point.bottomright.up.fill")
                                    
                                    
                                    Text("Route")
                                        .font(.caption2)
                                    
                                }
                                .foregroundColor( routeIconColor(route: route))
                                
                                
                            }
                            
                            .sheet(isPresented: $showRouteView) {
                                RouteView(showRouteView: $showRouteView, route: route, destination: $selectedMapItem, transportationType: $transportationType, distanceFormatter: distanceFormatter)
                                    .presentationDetents([.fraction(0.50),.fraction(0.75),.large])
                            }
                            padding([.leading, .trailing])
                            
                            
                            // MARK: - Settings
                            
                            Button{
                                showSettingsView = true
                            } label: {
                                VStack{
                                    Image(systemName: "gear.circle.fill").foregroundColor(toolbarColor)
                                    Text("Settings")
                                        .font(.caption2)
                                        .foregroundColor(toolbarColor)
                                }
                            }
                            .sheet(isPresented: $showSettingsView) {
                                SettingsView(showSettingsView: $showSettingsView, selectedMapOption: $selectedMapOption, colorScheme: $colorScheme, transportationType: $transportationType, distanceFormatter: distanceFormatter)
                                    .presentationDetents([.large, .medium, .fraction(0.75), .fraction(0.50)])
                            }
                            padding([.trailing])
                            
                        } //HStack
                        
                    } //ToolBarItemGroup
                    
                } //.toolbar
                
                VStack{
                    if finalDestination != nil {
                        Button {
                            MKMapItem.openMaps(with: [finalDestination!])
                        } label: {
                            Text("Route to Final Destination")
                                .font(.system(size: 10))
                        }
                        .disabled(false)
                        .background(Color(red: 0, green: 0, blue: 0.5))
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding()
                    }
                    if waypointDestination != nil {
                        Button {
                            MKMapItem.openMaps(with: [waypointDestination!])
                        } label: {
                            Text("Route to Waypoint Destination")
                                .font(.system(size: 10))
                        }
                        .disabled(false)
                        .disabled(false)
                        .background(Color(red: 0, green: 0, blue: 0.5))
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                    }
                }
            } // Zstack
        } //NavigationView
        .preferredColorScheme(colorScheme.colorStyle)

    } // body
}

//#Preview {
//    ContentView()
//}
