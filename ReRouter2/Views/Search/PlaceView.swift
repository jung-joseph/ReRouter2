//
//  PlaceView.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/20/23.
//

import SwiftUI
import MapKit

struct PlaceView: View {
    
    @State var nameTextField: String = ""
    @State var editName: Bool = false
    
    var mapItem: MKMapItem
    @Bindable var distanceFormatter: DistanceFormatter
    @Binding var showSearchView: Bool
    
    private var address: String {
        let placemark = mapItem.placemark
        return "\(placemark.thoroughfare ?? "") \(placemark.subThoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")"
    }
    
    
    private var distance: Measurement<UnitLength>? {
        guard let userLocation = LocationManager.shared.manager.location,
              let destinationLocation = mapItem.placemark.location
        else {
            return nil
        }

        return calculateDistance(from: userLocation, to: destinationLocation)
    }
    
    var body: some View {

            VStack(alignment: .leading) {

                if editName {
                    HStack {
                        TextField(mapItem.name ?? "", text: $nameTextField)
                            .onSubmit {
                                mapItem.name = nameTextField
                                editName.toggle()
                            }
                            .textFieldStyle(.roundedBorder)
                            .font(.title3)
                         
                        Spacer()
                        
                        Image(systemName: "square.and.pencil.circle.fill")
                            .onTapGesture {
                                editName.toggle()
                            }
                        
                    }
                } else {
                    HStack{
                        Text(mapItem.name ?? "")
                            .font(.title3)
                        
                        Spacer()
                        
                        Image(systemName: "square.and.pencil.circle.fill")
                            .onTapGesture {
                                editName.toggle()
                            }
                    }
                }
                Text(address)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let distance {
                    //                Text(distance, formatter: MeasurementFormatter.distance)
                    // Be careful here! distance is a Measurement type and distanceFormatter works on strings and uses DistanceUnits!
                    if distanceFormatter.unitOptions == .kilometers {
                        let distanceInKilometers = distance.converted(to: .kilometers)
                        Text("\(distanceInKilometers.displayDistance(.kilometers))")
                    } else {
                        let distanceInMiles = distance.converted(to: .miles)
                        Text("\(distanceInMiles.displayDistance(.miles))")
                    }
                }
                
                if let phone = mapItem.phoneNumber {
                    Text(phone)
                }
                
        }
    }
}

// #Preview {
//     PlaceView(mapItem: PreviewData.apple)
// }
 
