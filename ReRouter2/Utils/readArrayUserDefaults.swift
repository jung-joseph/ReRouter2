//
//  readArrayUserDefaults.swift
//  ReRouter2
//
//  Created by Joseph Jung on 1/8/24.
//

import Foundation
import MapKit

func readArrayUserDefaults(arrayIn: [MKMapItem]) -> [MKMapItem]? {
    let tempFavoriteMapItems: [MKMapItem] = []
    do {
        if let data = UserDefaults.standard.data(forKey: "savedMapItems") {
            if let tempFavoriteMapItems = try NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: MKMapItem.self, from: data){
                return tempFavoriteMapItems
            }
        }
    } catch {
        print("try failed")
    }
    
    return tempFavoriteMapItems
}
