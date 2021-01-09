//
//  MarketDataProvider.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/9/21.
//

import Foundation

protocol MarketDataProviderProtocol {
    func fetchPosts(success: @escaping ([Market]) -> Void, failure: @escaping (Error) -> Void)
}

final class MarketNetworkDataProvide : MarketDataProviderProtocol{
    func fetchPosts(success: @escaping ([Market]) -> Void, failure: @escaping (Error) -> Void) {
        let urlString = "https://api.jsonbin.io/b/5ff1946009f7c73f1b6d134f"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url){(data, response, error) in
            if let error = error {
                failure(error)
            } else if let data = data {
                do {
                    let markets = try JSONDecoder().decode([Market].self, from: data)
                    DispatchQueue.main.async {
                        success(markets)
                    }
                } catch {
                    failure(error)
                }
            }
        }.resume()
    }
}

