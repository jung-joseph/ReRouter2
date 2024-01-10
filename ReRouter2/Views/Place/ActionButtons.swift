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
                        Text("Route with Apple Maps")
                            .font(.system(size: 10))
                        
                    }
                }).buttonStyle(.bordered)
                
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
                        
                        /*
                        do {
                            
                          
                            if let data = UserDefaults.standard.data(forKey: "savedMapItems") {
                                if let tempFavoriteMapItems = try NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: MKMapItem.self, from: data){
                                    
                                    favoriteMapItems.removeAll()

                                    tempFavoriteMapItems.forEach { item in
                                        print("mapItem Name: \(String(describing: item.name))")
                                        favoriteMapItems.append(item)
                                    }
                                    if (mapItem != nil){
                                        favoriteMapItems.append(mapItem!)
                                    }
                                    
                                }
                            }
                        } catch {
                            print("try failed")
                        }
                    
                                                
                        do {
                            let data = try NSKeyedArchiver.archivedData(withRootObject: favoriteMapItems as Any, requiringSecureCoding: false)
                            UserDefaults.standard.set(data, forKey:"savedMapItems")
                            
                        } catch {
                            print("Failed to create Archive of favoriteMapItems")
                            // save just the current mapItem
                            UserDefaults.standard.set(mapItem, forKey: "savedMapItems")
                        }
                         */
                        
 
                    },
                           label: {
                        HStack{
                            Image(systemName: "star.fill")
                            Text("Add to Favorites")
                                .font(.system(size: 10))
                        }
                    }).buttonStyle(.bordered)
                }
                //                MARK: - Retrieve save MapItem
                HStack{
                    Button(action: {
                        
                        do {
                            if let data = UserDefaults.standard.data(forKey: "savedMapItems") {
                                if let favoriteMapItems = try NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: MKMapItem.self, from: data){
                                    favoriteMapItems.forEach { item in
                                        print("mapItem Name: \(String(describing: item.name))")
                                    }
                                }
                            }
                        } catch {
                            print("try failed")
                        }
                        
                        
                    },
                           label: {
                        HStack{
                            Image(systemName: "star.fill")
                            Text("Get to Favorites")
                                .font(.system(size: 10))
                        }
                    }).buttonStyle(.bordered)
                }
            }
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
                        }
                    }).buttonStyle(.bordered)
                }
                
            }
            
        }
        
    }



//#Preview {
//    ActionButtons(mapItem: PreviewData.apple)
//}
