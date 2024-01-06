//
//  Settings.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/23/23.
//

import SwiftUI
import MapKit
import Observation

//enum DistanceUnit: String, Codable, CaseIterable {
//    case miles
//    case kilometers
//}
//
//extension DistanceUnit{
//    var title: String {
//        switch self {
//        case .miles:
//            return "mi"
//        case .kilometers:
//            return "km"
//        }
//    }
//}

enum TransportationOptions: String, Identifiable, CaseIterable {
    case automobile
    case walking
    case transit
    
    var id: String {
        self.rawValue
    }
    
    var transportationOption: MKDirectionsTransportType {
        switch self {
        case .automobile:
            return .automobile
        case .walking:
            return .walking
        case .transit:
            return .transit

        }
    }
}
enum ColorSchemeOptions: String, Identifiable, CaseIterable {
    case light
    case dark
    
    var id: String {
        self.rawValue
    }
    
    var colorStyle: ColorScheme {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark

        }
    }
}

enum MapOptions: String, Identifiable, CaseIterable {
    
    case standard
    case hybrid
    case imagery
    
    var id: String {
        self.rawValue
    }
    
    var mapStyle: MapStyle {
        switch self {
        case .standard:
            return .standard
        case .hybrid:
            return .hybrid
        case .imagery:
            return .imagery
        }
    }
}

//@Observable
//class Settings{
//    var colorScheme: ColorScheme = .dark
//    var distanceUnit: DistanceUnit = .miles
//    var mapType: MapStyle = .standard
//    var transportationType: MKDirectionsTransportType = .automobile
//}

