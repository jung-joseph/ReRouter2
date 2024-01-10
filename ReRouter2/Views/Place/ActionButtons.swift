//
//  ActionButtons.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/20/23.
//

import SwiftUI
import MapKit

struct ActionButtons: View {
    
    @Binding var mapItem: MKMapItem?
    @Binding var mapItems: [MKMapItem]
    @Binding var favoriteMapItems: [MKMapItem]
    @Binding var finalDestination: MKMapItem?
    @Binding var waypointDestination: MKMapItem?
    @Binding var selectedDetents: PresentationDetent
    
    //    @State var showMapItemNameEditor: Bool = false
    //    @State var newMapItemName: String = ""
    
    var body: some View {
        HStack {
            Spacer()
            VStack{
                //   MARK: - ROUTE WITH APPLE MAPS
                
                Button(action: {
                    //action
                    if let mapItem{
                        MKMapItem.openMaps(with: [mapItem])
                    }
                    
                }, label: {
                    HStack {
                        Image(systemName: "car.circle.fill")
                        Text("Route to this Destination")
                            .font(.system(size: 10))
                        
                    }
                }).buttonStyle(.bordered)
                
                Button {
                    if (finalDestination != nil) && (waypointDestination != nil){
                        MKMapItem.openMaps(with: [waypointDestination!,finalDestination!])
                    }
                } label: {
                    HStack {
                        Image(systemName: "car.circle.fill")
                        Text("Route to Way Point & Final Destingation")
                            .font(.system(size: 10))
                        
                    }
                }

            }
            .buttonStyle(.bordered)
            
            VStack{
                //MARK: - Add to Favorites
                HStack{
                    Button(action: {
                        // get the current savedFavorites
                        if let readFavoriteMapItems = readArrayUserDefaults(arrayIn: favoriteMapItems){
                            favoriteMapItems.removeAll()
                            print("appending old favoriteMapItems")
                            readFavoriteMapItems.forEach() { item in
                                print("mapItem Name: \(String(describing: item.name))")
                                favoriteMapItems.append(item)
                            }
                        }
                        // add this mapItem
                        if (mapItem != nil){
                            favoriteMapItems.append(mapItem!)
                        }
                        writeArrayUserDefaults(arrayIn: favoriteMapItems, mapItem: mapItem!)
                        
                        
                        
                    },
                           label: {
                        HStack{
                            Image(systemName: "star.fill")
                            Text("Add to Favorites")
                                .font(.system(size: 10))
                        }
                    }).buttonStyle(.bordered)
                }
                //                MARK: - Set as Waypoint Destination
                HStack{
                    Button(action: {
                        
                        waypointDestination = mapItem
                        print("waypointDestination: \(String(describing: waypointDestination!.name))")
                        
                        
                    },
                           label: {
                        HStack{
                            Text("Set as Waypoint")
                                .font(.system(size: 10))
                        }
                    }).buttonStyle(.bordered)
                }
//                MARK: - Set as Final Destination
                HStack {
                    Button {
                        finalDestination = mapItem
                        print("finalDestination: \(String(describing: finalDestination!.name))")

                    } label: {
                        HStack{
                            Text("Set as Final Destination")
                                .font(.system(size: 10))
                        }
                    }

                }
            }
            .buttonStyle(.bordered)
            VStack{
            //   MARK: - Website Link
            if let url = mapItem?.url {
                HStack{
                    Link(destination: url, label: {
                        HStack{
                            Image(systemName: "link")
                            Text("Website")
                                .font(.system(size: 10))
                            
                        }
                    }).buttonStyle(.bordered)
                }
            }
            //MARK: - phone button
            if mapItem?.phoneNumber != nil {
                Button(action: {
                    if let phone = mapItem?.phoneNumber {
                        let numericPhoneNumber = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                        makeCall(phone: numericPhoneNumber)
                    }
                }, label: {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text("Call") 
                            .font(.system(size: 10))

                    }
                }).buttonStyle(.bordered)
            }
        }
                
            }
            
        }
        
    }



//#Preview {
//    ActionButtons(mapItem: PreviewData.apple)
//}
