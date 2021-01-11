//
//  MarketDataProvider.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/9/21.
//

import Foundation

final class MarketNetworkDataProvider{
    
    typealias result<T> = (Result<[T], Error>) -> Void

    func getDataFromUrl<T: Decodable>(of type: T.Type, from url: String, completion: @escaping result<T>){
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url){(data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decodedData: [T] = try JSONDecoder().decode([T].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

