//
//  writeArrayUserDefaults.swift
//  ReRouter2
//
//  Created by Joseph Jung on 1/7/24.
//

import Foundation
import MapKit

func writeArrayUserDefaults(arrayIn: [MKMapItem],mapItem: MKMapItem?) {
    
    
    
    do {
        let data = try NSKeyedArchiver.archivedData(withRootObject: arrayIn as Any, requiringSecureCoding: false)
        UserDefaults.standard.set(data, forKey:"savedMapItems")
        
    } catch {
        print("Failed to create Archive of favoriteMapItems")
        // save just the current mapItem
        UserDefaults.standard.set(mapItem!, forKey: "savedMapItems")
    }
    
}
