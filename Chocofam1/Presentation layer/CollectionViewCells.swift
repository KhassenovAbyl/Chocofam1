//
//  CollectionViewCells.swift
//  Chocofam1
//
//  Created by Abylbek Khassenov on 1/15/21.
//

import UIKit

class CollectionViewCells: UICollectionViewCell {
    //for cell of first type
    @IBOutlet weak var tittleLabel1: UILabel!
    @IBOutlet weak var tittleLabel2: UILabel!
    @IBOutlet weak var view1Cell1: UIView!
    @IBOutlet weak var view2Cell1: UIView!
    @IBOutlet weak var rateCell1: UILabel!
    @IBOutlet weak var minDeliveryCostCell1: UILabel!
    @IBOutlet weak var minOrderCost1: UILabel!
    @IBOutlet weak var time1: UILabel!
    
    //for cell of second type
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var view1cell2: UIView!
    @IBOutlet weak var view2cell2: UIView!
    @IBOutlet weak var rate2cell2: UILabel!
    @IBOutlet weak var minDeliveryCost2: UILabel!
    @IBOutlet weak var minOrderCost2: UILabel!
    @IBOutlet weak var time2: UILabel!
    
    
    func makeRounded(){
        view1Cell1.layer.cornerRadius = 10
        view2Cell1.layer.cornerRadius = 10
        imageView1.layer.cornerRadius = 10
    }
}
