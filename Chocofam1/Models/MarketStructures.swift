//
//  MarketStructures.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/11/21.
//

import Foundation

struct delivery_tariff: Decodable{
    var title: String
    var conditions: [conditions]
    var pk: String
}

struct delivery_time: Decodable {
    var low_limit_minutes: Int
    var upper_limit_minutes: Int
    var pk: String
}

struct restaurant: Decodable {
    var title: String
    var schedule: [schedule]
}

struct conditions: Decodable {
    var delivery_cost: Int
    var order_min_cost: Int
}

struct schedule: Decodable {
    var started_week_day: String
    var started_at: started_at
    var ended_week_day: String
    var ended_at: ended_at
}

struct started_at: Decodable {
    var hour: Int
    var minute: Int
}

struct ended_at: Decodable {
    var hour: Int
    var minute: Int
}
