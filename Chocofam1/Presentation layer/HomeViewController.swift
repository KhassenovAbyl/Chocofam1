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
            for i in self.viewModel.markets{
                print(i)
            }
        }
        viewModel.didGetError = { error in
            print(error)
        }
    }
    
}
