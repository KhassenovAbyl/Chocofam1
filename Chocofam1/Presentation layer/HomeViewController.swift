//
//  HomeViewController.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/9/21.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            cell1.tittleLabel1.text = self.viewModel.markets[indexPath.row].restaurant.title
            cell1.imageView1.sd_setImage(with: URL(string: self.viewModel.markets[indexPath.row].restaurant.image) , placeholderImage: UIImage(named: "default"))
            return cell1
        }else{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCells
            cell2.tittleLabel2.text = self.viewModel.markets[indexPath.row].restaurant.title
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
