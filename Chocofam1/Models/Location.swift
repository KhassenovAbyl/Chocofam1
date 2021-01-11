//
//  Location.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/11/21.
//

import Foundation

struct border: Decodable {
    var latitude: Double
    var longitude: Double
}
struct Location: Decodable {
    var title: String
    var border: [border]
    var time_zone: String
    var own_delivery_available: Bool
    var pk: String
}
