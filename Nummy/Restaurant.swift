//
//  RestaurantModel.swift
//  Nummy
//
//  Created by Cheng Sun on 2015-07-31.
//  Copyright (c) 2015 Cheng Sun. All rights reserved.
//

import Foundation


class Restaurant {
    var name : String
    var phone : String
    var address : String
    var about : String
    var upvote : Int
    var latitude : Float
    var longitude : Float
    var isActive : Bool
    var picture : String
    var tag : [String]
    
    init(name :String, phone: String, address: String, about: String,
        upvote:Int, latitude: Float,longitude:Float,picture:String,tag:[String]){
            self.name = name
            self.phone = phone
            self.address = address
            self.about = about
            self.upvote = upvote
            self.latitude = latitude
            self.longitude = longitude
            self.isActive = true
            self.picture = picture
            self.tag = tag
    }
    
}