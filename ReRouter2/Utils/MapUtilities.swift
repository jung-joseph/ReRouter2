//
//  MapUtilities.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/20/23.
//

import Foundation
import MapKit

//func openAppleMaps(destination:MKMapItem) {
//    MKMapItem.openMaps(with: [destination])
//}

func requestCalculateDirections(selectedMapItem: MKMapItem?, locationManager:LocationManager, transportationType: TransportationOptions) async -> MKRoute? {
//    route = nil
    if let selectedMapItem {
        guard let currentUserLocation = locationManager.manager.location else {
            return nil}
        let startingMapItem = MKMapItem(placemark: MKPlacemark(coordinate: currentUserLocation.coordinate))
        
        
        return  await calculateDirections(from: startingMapItem, to: selectedMapItem, transportationType: transportationType)
        
    } else {
        return nil
    }
}
func makeCall(phone: String){
    if let url = URL(string: "tel://\(phone)") {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Device can't make phone calls")
        }
    }
}
func calculateDirections(from: MKMapItem, to: MKMapItem, transportationType: TransportationOptions) async -> MKRoute? {
    
    let directionsRequest = MKDirections.Request()
//    directionsRequest.transportType = .automobile
    directionsRequest.transportType = transportationType.transportationOption

    directionsRequest.source = from
    directionsRequest.destination = to
    
    let directions = MKDirections(request: directionsRequest)
    
    let response = try? await directions.calculate()
    return response?.routes.first
}

func calculateDistance (from: CLLocation, to: CLLocation) -> Measurement<UnitLength> {
    let distanceInMeters = from.distance(from: to)
    return Measurement(value: distanceInMeters, unit: .meters)
}

func performSearch(searchTerm: String, visibleRegion: MKCoordinateRegion?) async throws -> [MKMapItem] {
    
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = searchTerm
//    request.resultTypes = .pointOfInterest
    request.resultTypes = [.address, .pointOfInterest]

    
    guard let region = visibleRegion else { return [] }
    request.region = region
    
    let search = MKLocalSearch(request: request)
    let response = try await search .start()
    
    return response.mapItems
}
