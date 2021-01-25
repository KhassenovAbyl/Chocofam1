//
//  TableViewCell.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/23/21.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageForFood: UIImageView!
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setupCell(food : foods){
        imageForFood.sd_setImage(with: URL(string: food.logo ?? ""), placeholderImage: UIImage(named: "default"))
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        imageForFood.layer.cornerRadius = 15
        tittleLabel.text = food.title
        definitionLabel.text = food.selling_text
        priceLabel.text = "\(food.price) тг"
    }
    
}
