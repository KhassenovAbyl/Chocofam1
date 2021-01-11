//
//  Market.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/9/21.
//

import Foundation

struct Market: Decodable {
    let delivery_tariff: delivery_tariff
    let delivery_time: delivery_time
    let restaurant: restaurant
    let is_top_restaurant: Bool
}
