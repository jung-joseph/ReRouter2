//
//  MeasurementFormatter+Extensions.swift
//  ReRouter
//
//  Created by Joseph Jung on 10/20/23.
//

import Foundation

extension MeasurementFormatter {
    
    static var distance: MeasurementFormatter {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.unitOptions = .naturalScale
//        formatter.locale = Locale.current
        formatter.locale = Locale(identifier: "en_FR")
        return formatter
    }
}
