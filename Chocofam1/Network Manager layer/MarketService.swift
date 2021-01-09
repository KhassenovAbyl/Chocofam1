//
//  MarketService.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/9/21.
//

import Foundation

protocol MarketServiceProtocol {
    func getMarkets(success: @escaping ([Market]) -> Void, failure: @escaping (Error) -> Void)
}

final class MarketService: MarketServiceProtocol{
    
    
    func getMarkets(success: @escaping ([Market]) -> Void, failure: @escaping (Error) -> Void) {
        if localStorage.obtainPost().isEmpty {
            dataProvider.fetchPosts { [weak self] posts in
                self?.localStorage.save(posts: posts)
                success(posts)
            } failure: { error in
                failure(error)
            }
        } else {
            success(localStorage.obtainPost())
        }
    }
    
    
}
