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
    var markets: [Market] = []
    var locations: [Location] = []
    var menu: Menu = Menu.init(food_types: [])
    private let marketService = MarketNetworkDataProvider()
    
    func getMarkets(start: Int , lat: String , long: String){
        didStartRequest()
        marketService.getDataFromUrl(of: Market.self, from: "https://hermes.chocofood.kz/api/delivery_areas/restaurants/?latitude=\(lat)&&&longitude=\(long)&offset=\(start)&limit=\(10)"){ (result) in
            switch result{
                case .success(let markets):
                    self.markets += markets
                    self.didEndRequest()
                case .failure(let error):
                    print(error)
                    self.didGetError(error)
            }
        }
    }
    func getMenu(pk : String){
        didStartRequest()
        marketService.getDictFromUrl(of: Menu.self, from: "https://hermes.chocofood.kz/api/extended_restaurants/\(pk)/") { (result) in
            switch result{
                case .success(let menu):
                    self.menu = menu
                    self.didEndRequest()
                case .failure(let error):
                    print(error)
                    self.didGetError(error)
            }
        }
    }
}


//        marketService.getDataFromUrl(of: Location.self, from: "https://hermes.testchocofood.kz/api/cities/"){ (result) in
//                switch result{
//                    case .success(let loc):
//                        self.locations = loc
//                        self.didEndRequest()
//                    case .failure(let error):
//                        print(error)
//                        self.didGetError(error)
//                }
//            }
