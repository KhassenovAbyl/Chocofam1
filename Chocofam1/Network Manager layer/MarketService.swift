//
//  MarketService.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/9/21.
//

import Foundation

final class MarketService{
    
    var dataProvider = MarketNetworkDataProvider()
    
    func getMarkets(success: @escaping ([Market]) -> Void, failure: @escaping (Error) -> Void) {
            dataProvider.getPostsFromUrl{ posts in
                success(posts)
            } failure: { error in
                failure(error)
            }
        }
    }
