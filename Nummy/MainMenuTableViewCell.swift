//
//  MainMenuTableViewCell.swift
//  Nummy
//ite//  Created by Cheng Sun on 2015-07-31.
//  Copyright (c) 2015 Cheng Sun. All rights reserved.
//

import UIKit

class MainMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var upvote: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var restaurant_image: UIImageView!
    
    func configureWithMainMenu(data : JSON) {
        let restaurant_name = data["name"].string
        let restaurant_upvote = data["upvote"].int!
        let restaurant_address = data["address"].string
        let restaurant_background = data["picture"].string
        
        name.text = restaurant_name
        upvote.text = String(restaurant_upvote)
        address.text = restaurant_address
        restaurant_image.image = UIImage(named: restaurant_background!)
        
    }
    
    
}
