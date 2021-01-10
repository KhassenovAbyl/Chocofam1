//
//  ViewModel.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/9/21.
//

import Foundation

final class HomeViewModel {
    var didStartRequest: () -> Void = {}
    var didEndRequest: () -> Void = {}
    var didGetError: (Error) -> Void = {_ in }
    private(set) var markets: [Market] = []
    private let marketService = MarketService()
    
    func getMarkets() {
        didStartRequest()
        marketService.getMarkets { [weak self] markets in
            self?.markets = markets
            self?.didEndRequest()
        } failure: { [weak self] error in
            self?.didGetError(error)
        }
    }
}
