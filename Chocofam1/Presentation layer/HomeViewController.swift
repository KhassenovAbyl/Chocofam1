//
//  HomeViewController.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/9/21.
//

import UIKit
import SDWebImage
import CoreLocation

class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    
    //for map
    let locationManager = CLLocationManager()
    var lat : String?
    var long : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for map
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
        }
        
        viewModel.getMarkets(start: 0 , lat: lat ?? "43.236511", long: long ?? "76.91573")
        StartURLSession()
        self.collectionView.reloadData()
    }
    
    private func StartURLSession() {
        viewModel.didStartRequest = {}
        viewModel.didEndRequest = {
            self.collectionView.reloadData()
        }
        viewModel.didGetError = {error in print(error)}
    }
}


extension HomeViewController: UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.markets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row % 4 == 0 || indexPath.row % 4 == 1{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! Cell1
            cell1.setupCell(market: viewModel.markets[indexPath.row])
            return cell1
        }else{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! Cell2
            cell2.setupCell(market: viewModel.markets[indexPath.row])
            return cell2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.markets.count - 1{
            self.viewModel.getMarkets(start: viewModel.markets.count - 1 , lat: lat ?? "43.236511", long: long ?? "76.91573")
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MenuViewController
        if let indexPath = collectionView.indexPathsForSelectedItems?.last {
            destination.pk = viewModel.markets[indexPath.item].restaurant.pk
            destination.name = viewModel.markets[indexPath.row].restaurant.title
            destination.price1 = "\(viewModel.markets[indexPath.row].delivery_tariff.conditions[0].delivery_cost)"
            destination.price2 = "\(viewModel.markets[indexPath.row].delivery_tariff.conditions[0].order_min_cost)"
            destination.imageString = viewModel.markets[indexPath.row].restaurant.image
            destination.time = "\(viewModel.markets[indexPath.row].delivery_time.low_limit_minutes) - \(viewModel.markets[indexPath.row].delivery_time.upper_limit_minutes) + мин"
            destination.review = "\(Double((viewModel.markets[indexPath.row].restaurant.rating)*5/100)) + Отзывы"
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            self.lat = String(location.coordinate.latitude)
            self.long = String(location.coordinate.longitude)
        }
    }
}
