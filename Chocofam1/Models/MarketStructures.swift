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
    var logo: String
    var image: String
    var synonyms: [String]
    var payment_methods: payment_methods
    var will_be_delivered_by: String
    var location: location
    var pk: String
    var categories: [categories]
    var state: String
    var rating: Int
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

struct payment_methods: Decodable{
    var cash: Bool
    var bonus: Bool
    var card: Bool
    var rakhmet: Bool
}

struct location: Decodable {
    var coordinate: coordinate
    var text: String
}

struct coordinate: Decodable {
    var latitude: Double
    var longitude: Double
}

struct categories: Decodable{
    var title: String
    var position: Int
    var active_icon: String
    var inactive_icon: String
    var pk: String
}
