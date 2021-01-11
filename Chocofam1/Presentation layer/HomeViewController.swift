//
//  HomeViewController.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/9/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .red
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMarkets()
        StartURLSession()
    }
    
    private func StartURLSession() {
        viewModel.didStartRequest = {
            self.activityIndicator.startAnimating()
        }
        viewModel.didEndRequest = {
            self.activityIndicator.stopAnimating()
            print(self.viewModel.markets)
            print("-------------------------------------")
            print(self.viewModel.locations)
        }
        viewModel.didGetError = { error in
            print(error)
        }
    }
    
    
}
