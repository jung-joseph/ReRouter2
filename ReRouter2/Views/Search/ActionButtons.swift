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
    @Binding var destinationMapItems: [MKMapItem]
    @Binding var selectedDetents: PresentationDetent
    
    //    @State var showMapItemNameEditor: Bool = false
    //    @State var newMapItemName: String = ""
    
    var body: some View {
        HStack {
            Spacer()
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
