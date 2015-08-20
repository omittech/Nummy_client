//
//  RestaurantTableViewCell.swift
//  Nummy
//
//  Created by Cheng Sun on 2015-08-04.
//  Copyright (c) 2015 Cheng Sun. All rights reserved.
//

import UIKit

protocol RestaurantCollectionViewCellDelegate : class {
    func RestaurantTableViewAddItemDidTouch(cell: RestaurantCollectionViewCell, sender: AnyObject)
}



class RestaurantCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var itemname: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var AddButton: SpringButton!
    @IBOutlet weak var ItemImage: UIImageView!
    
    
    weak var delegate : RestaurantCollectionViewCellDelegate?
    
    @IBAction func AddItem(sender: AnyObject) {
        
        AddButton.animation = "pop"
        AddButton.force = 1
        AddButton.animate()
        
        delegate?.RestaurantTableViewAddItemDidTouch(self, sender: sender)
    }
    
    
    
    func configureWithItems(data : JSON) {
        var item_name = ""
        var item_price = ""
        
        
        if(data != nil) {
         item_name = data["name"].string!
         item_price = data["price"].string!
         ItemImage.image = UIImage(named: data["picture"].string!)
        }
//        else {
//            self.backgroundColor = UIColor.whiteColor()
//        }
        
        itemname.text = item_name
        price.text = item_price
    }


}
