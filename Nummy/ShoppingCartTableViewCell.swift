//
//  ShoppingCarTableViewCell.swift
//  Nummy
//
//  Created by Cheng Sun on 2015-08-09.
//  Copyright (c) 2015 Cheng Sun. All rights reserved.
//

import UIKit
import CoreData

protocol ShoppingCartTableViewCellDelegate: class {
    func ShoppingCartTableViewCellDidTouchIncrease(cell: ShoppingCartTableViewCell, sender: AnyObject)
    func ShoppingCartTableViewCellDidTouchDecrease(cell: ShoppingCartTableViewCell, sender: AnyObject)
}

class ShoppingCartTableViewCell: UITableViewCell {

    @IBOutlet weak var itemname: UILabel!
    @IBOutlet weak var numOfItem: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var upButton: SpringButton!
    @IBOutlet weak var downButton: SpringButton!
    weak var delegate: ShoppingCartTableViewCellDelegate?
    
    var myCart : Array<AnyObject> = []
    
    
    @IBAction func ShoppingCartTableViewUpDidTouch(sender: AnyObject) {
        upButton.animation = "pop"
        upButton.force = 3
        upButton.animate()
        
        delegate?.ShoppingCartTableViewCellDidTouchIncrease(self, sender: sender)
    }
    
    @IBAction func ShoppingCarTableViewDownDidTouch(sender: AnyObject) {
        downButton.animation = "pop"
        downButton.force = 3
        downButton.animate()
        
        delegate?.ShoppingCartTableViewCellDidTouchDecrease(self, sender: sender)
    }

    func configureWithShoppingcart(data : AnyObject) {
        let amount = data.valueForKey("amount") as! NSNumber
        
        itemname.text = data.name
        numOfItem.text = amount.stringValue
        price.text = data.valueForKey("price") as? String
    }
    
    func updateNumOfItemWithShoppingcart(cell : ShoppingCartTableViewCell){
        var appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        let entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: context)
        
        var request = NSFetchRequest(entityName: "Item")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "name = %@", cell.itemname.text!)
        var results = context.executeFetchRequest(request, error: nil)
        
        for result : AnyObject in results! {
            result.setValue(cell.numOfItem.text!.toInt()!, forKey: "amount")
        }
        
        context.save(nil)
    }
    
    func getAllItemsInShoppingCart() -> AnyObject {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "Item")
        
        var request = NSFetchRequest(entityName: "Item")
        request.returnsObjectsAsFaults = false
        var results = context.executeFetchRequest(request, error: nil)
        
        if results!.count > 0 {
            for result : AnyObject in results! {
                myCart.append(result)
            }
        }
        return myCart
    }

    
}
