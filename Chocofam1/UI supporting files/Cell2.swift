//
//  Cell2.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/19/21.
//

import UIKit

class Cell2: UICollectionViewCell {
    
    @IBOutlet weak var tittleLabel2: UILabel!
    @IBOutlet weak var viewCell2: UIView!
    @IBOutlet weak var view2cell2: UIView!
    @IBOutlet weak var view3cell2: UIView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var rateLabel2: UILabel!
    @IBOutlet weak var deliverLabel2: UILabel!
    @IBOutlet weak var coinLabel2: UILabel!
    @IBOutlet weak var timeLabel2: UILabel!
    
    func setupCell(market : Market){
        viewCell2.layer.cornerRadius = 10
        view2cell2.layer.cornerRadius = 10
        view3cell2.layer.cornerRadius = 10
        imageView2.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
        tittleLabel2.text = market.restaurant.title
        rateLabel2.text = String(Double(market.restaurant.rating)*5/100)
        deliverLabel2.text = "от " +  String(market.delivery_tariff.conditions[0].delivery_cost) + " тг"
        coinLabel2.text = String(market.delivery_tariff.conditions[0].order_min_cost) + " тг"
        timeLabel2.text = String(market.delivery_time.low_limit_minutes) + " мин"
        imageView2.sd_setImage(with: URL(string: market.restaurant.image) , placeholderImage: UIImage(named: "default"))
    }
}
