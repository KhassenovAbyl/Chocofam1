//
//  Menu.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/22/21.
//

import Foundation

struct Menu: Decodable{
    var food_types: [food_types]
}

struct food_types : Decodable{
    var title: String
    var dishes_cost: Int
    var oid: String
    var position: Int
    var foods: [foods]
}

struct foods: Decodable{
    var title: String
    var state: String
    var price: Int
    var logo: String?
    var selling_text: String
    var oid: String
    var position: Int
}
