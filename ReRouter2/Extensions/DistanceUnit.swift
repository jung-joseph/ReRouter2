//
//  DistanceUnit.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/23/23.
//

import Foundation
import SwiftUI

enum DistanceUnit: String, Codable, CaseIterable , Identifiable {
    case miles
    case kilometers

    var id: String {
        self.rawValue
    }
 
    var title: String {
        switch self {
        case .miles:
            return "mi"
        case .kilometers:
            return "km"
        }
    }

}
