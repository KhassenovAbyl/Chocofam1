//
//  Market.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/9/21.
//

import Foundation

struct conditions: Decodable {
    var delivery_cost: Int
    var order_min_cost: Int
}

struct delivery_tariff: Decodable{
    var title: String
    var conditions: [conditions]
    var pk: String

    enum CodingKeys : String , CodingKey{
        case title
        case conditions
        case pk
    }
}

struct delivery_time: Decodable {
    var low_limit_minutes: Int
    var upper_limit_minutes: Int
    var pk: String
    
    enum CodingKeys : String , CodingKey{
        case low_limit_minutes
        case upper_limit_minutes
        case pk
    }
}

struct restaurant: Decodable {
    var title : String
    
    enum CodingKeys : String , CodingKey{
        case title
    }
}

struct Market: Decodable {
    let delivery_tariff: delivery_tariff
    let delivery_time: delivery_time
    let restaurant: restaurant
    let is_top_restaurant: Bool
}

