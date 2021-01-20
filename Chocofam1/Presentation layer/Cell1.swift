//
//  Cell1.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/19/21.
//

import UIKit
import SDWebImage

class Cell1: UICollectionViewCell {
    
    @IBOutlet weak var viewCell1: UIView!
    @IBOutlet weak var view2Cell1: UIView!
    @IBOutlet weak var view3cell1: UIView!
    @IBOutlet weak var tittleLabel1: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var rateLabel1: UILabel!
    @IBOutlet weak var deliverLabel1: UILabel!
    @IBOutlet weak var coinLabel1: UILabel!
    @IBOutlet weak var timeLabel1: UILabel!
    
    func setupCell(market : Market){
        viewCell1.layer.cornerRadius = 10
        view2Cell1.layer.cornerRadius = 10
        view3cell1.layer.cornerRadius = 10
        imageView1.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
        tittleLabel1.text = market.restaurant.title
        imageView1.sd_setImage(with: URL(string: market.restaurant.image) , placeholderImage: UIImage(named: "default"))
        rateLabel1.text = String(Double(market.restaurant.rating)*5/100)
        deliverLabel1.text = String(market.delivery_tariff.conditions[0].delivery_cost) + " тг"
        coinLabel1.text = String(market.delivery_tariff.conditions[0].order_min_cost) + " тг"
        timeLabel1.text = String(market.delivery_time.low_limit_minutes) + " мин"
    }
}
