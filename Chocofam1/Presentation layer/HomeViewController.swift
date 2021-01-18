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
        
        viewModel.getMarkets(start: 0)
        StartURLSession()
        self.collectionView.reloadData()
    }
    
    private func StartURLSession() {
        viewModel.didStartRequest = {}
        viewModel.didEndRequest = {
            self.loadCollection()
        }
        viewModel.didGetError = { error in print(error)}
    }
}

extension HomeViewController: UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.markets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row % 4 == 0 || indexPath.row % 4 == 1{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CollectionViewCells
            cell1.makeRounded()
            cell1.layer.cornerRadius = 10
            cell1.tittleLabel1.text = self.viewModel.markets[indexPath.row].restaurant.title
            cell1.rateCell1.text = String(Double(self.viewModel.markets[indexPath.row].restaurant.rating)*5/100)
            cell1.minDeliveryCostCell1.text = "от " +  String(self.viewModel.markets[indexPath.row].delivery_tariff.conditions[0].delivery_cost) + " тг"
            cell1.minOrderCost1.text = String(self.viewModel.markets[indexPath.row].delivery_tariff.conditions[0].order_min_cost) + " тг"
            cell1.time1.text = String(self.viewModel.markets[indexPath.row].delivery_time.low_limit_minutes) + " мин"
            cell1.imageView1.sd_setImage(with: URL(string: self.viewModel.markets[indexPath.row].restaurant.image) , placeholderImage: UIImage(named: "default"))
            return cell1
        }else{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCells
            cell2.layer.cornerRadius = 10
            cell2.view1cell2.layer.cornerRadius = 10
            cell2.view2cell2.layer.cornerRadius = 10
            cell2.tittleLabel2.text = self.viewModel.markets[indexPath.row].restaurant.title
            cell2.rate2cell2.text = String(Double(self.viewModel.markets[indexPath.row].restaurant.rating)*5/100)
            cell2.minDeliveryCost2.text = "от " +  String(self.viewModel.markets[indexPath.row].delivery_tariff.conditions[0].delivery_cost) + " тг"
            cell2.minOrderCost2.text = String(self.viewModel.markets[indexPath.row].delivery_tariff.conditions[0].order_min_cost) + " тг"
            cell2.time2.text = String(self.viewModel.markets[indexPath.row].delivery_time.low_limit_minutes) + " мин"
            cell2.imageView2.sd_setImage(with: URL(string: self.viewModel.markets[indexPath.row].restaurant.image) , placeholderImage: UIImage(named: "default"))
            return cell2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.markets.count - 1{
            self.viewModel.getMarkets(start: viewModel.markets.count - 1)
            self.perform(#selector(loadCollection), with: nil, afterDelay: 1.0)
            }
        }
    
    @objc func loadCollection(){
        self.collectionView.reloadData()
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
