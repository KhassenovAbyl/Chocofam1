//
//  MenuViewController.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/21/21.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {

    // MARK: Oulets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewInHeader: UIView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var collectionFoodTypes: UICollectionView!
    @IBOutlet weak var collectionFoodTypes2: UICollectionView!
    
    @IBOutlet weak var rahmetAppIconView: UIView!
    @IBOutlet weak var rahmetImage: UIImageView!
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var reviewsView: UIView!
    @IBOutlet weak var revewLabel: UILabel!
    
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deliveryNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    var TableHeaderHeight: CGFloat = 200
    var pk: String?
    var name: String?
    var price1: String?
    var price2: String?
    var time: String?
    var review: String?
    var imageString: String?
    var viewModel = HomeViewModel()
    
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMenu(pk: pk!)
        StartURLSession()
        UISettings()
        // Do any additional setup after loading the view.
    }
    
    private func UISettings(){
        rahmetAppIconView.layer.cornerRadius = 20
        rahmetImage.layer.cornerRadius = 20
        timeView.layer.cornerRadius = 20
        reviewsView.layer.cornerRadius = 20
        infoView.layer.cornerRadius = 20
        viewInHeader.layer.cornerRadius = 10
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        imageView.sd_setImage(with: URL(string: imageString!), placeholderImage: UIImage(named: "default"))
        nameLabel.text = name
        deliveryNameLabel.text = "Доставка от \(name!)"
        priceLabel.text = "\(price1!) тг ----------------------------- \(price2!) тг"
        timeLabel.text = time
        revewLabel.text = review
        collectionFoodTypes2.alpha = 0
    
        blurEffectView.frame = imageView.bounds
        blurEffectView.alpha = 0
        imageView.addSubview(blurEffectView)
    }
    
    private func StartURLSession() {
        viewModel.didStartRequest = {}
        viewModel.didEndRequest = {
            self.tableView.reloadData()
            self.collectionFoodTypes.reloadData()
            self.collectionFoodTypes2.reloadData()
        }
        viewModel.didGetError = { error in print(error)}
    }
}


    // MARK: Table settings
extension MenuViewController: UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.menu.food_types.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menu.food_types[section].foods.count
    }
    //10 141 ''' 1 17 12
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! TableViewCell
        cell.setupCell(food: viewModel.menu.food_types[indexPath.section].foods[indexPath.row])
        return cell
    }
    
    func scrollto(startIndex: IndexPath){
        tableView.scrollToRow(at: startIndex, at: .top , animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var rect = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: TableHeaderHeight)

        if tableView.contentOffset.y < 0{
            rect.origin.y = tableView.contentOffset.y
            rect.origin.x = tableView.contentOffset.y/2
            rect.size.height = -tableView.contentOffset.y + 200
            rect.size.width = -tableView.contentOffset.y + 414
        }
        imageView.frame = rect
        if tableView.contentOffset.y <= 160{
            navBar.backgroundColor = UIColor.white.withAlphaComponent(0)
            navBar.topItem?.title = ""
            blurEffectView.alpha = tableView.contentOffset.y/100
        }else{
            navBar.backgroundColor = #colorLiteral(red: 0.1817893401, green: 0.1817893401, blue: 0.1817893401, alpha: 1)
            navBar.topItem?.title = name
        }
        if tableView.contentOffset.y >= 325{
            collectionFoodTypes2.alpha = 1
            collectionFoodTypes.alpha = 0
            collectionFoodTypes2.snp.makeConstraints{
                $0.top.equalTo(navBar.snp.bottom).offset(0)
                $0.left.equalToSuperview().offset(0)
                $0.right.equalToSuperview().offset(0)
                $0.height.equalTo(40)
            }
        }else{
            collectionFoodTypes2.alpha = 0
            collectionFoodTypes.alpha = 1
            collectionFoodTypes.snp.makeConstraints{
                $0.top.equalTo(headerView.snp.bottom).offset(-40)
                $0.left.equalToSuperview().offset(0)
                $0.right.equalToSuperview().offset(0)
                $0.height.equalTo(40)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellSegue2"{
            let destination = segue.destination as! DetailedInfoVC
            if let index = tableView.indexPathsForSelectedRows?.last{
            destination.foodNameLabel.text = viewModel.menu.food_types[index.section].foods[index.row].title
            }
        }
    }
}

extension MenuViewController: UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionFoodTypes{
            return viewModel.menu.food_types.count
        }else{
            return viewModel.menu.food_types.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionFoodTypes2{
            let cell2 = collectionFoodTypes2.dequeueReusableCell(withReuseIdentifier: "collectionCell2", for: indexPath) as! CollectionViewCell2
            cell2.foodTypeLabel2.text = viewModel.menu.food_types[indexPath.row].title
            return cell2
        }else{
            let cell1 = collectionFoodTypes.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
            cell1.foodTypeLabel.text = viewModel.menu.food_types[indexPath.row].title
            return cell1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.scrollto(startIndex: indexPath)
        if collectionView == collectionFoodTypes2{
            let cell2 = collectionFoodTypes2.dequeueReusableCell(withReuseIdentifier: "collectionCell2", for: indexPath) as! CollectionViewCell2
            cell2.backgroundColor = .green
        }else{
            let cell1 = collectionFoodTypes.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
            cell1.backgroundColor = .green
        }
    }
}
