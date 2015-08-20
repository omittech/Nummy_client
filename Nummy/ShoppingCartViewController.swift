//
//  ShoppingCartViewController.swift
//  Nummy
//
//  Created by Cheng Sun on 2015-07-29.
//  Copyright (c) 2015 Cheng Sun. All rights reserved.
//

import UIKit
import CoreData

class ShoppingCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ShoppingCartTableViewCellDelegate {

    var myCart : Array<AnyObject> = []

    
    override func viewDidLoad() {
        
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
    }
    
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCart.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cart_cell") as! ShoppingCartTableViewCell
        
        cell.configureWithShoppingcart(myCart[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
     func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            context.deleteObject(myCart[indexPath.row] as! NSManagedObject)
            myCart.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
            var error: NSError? = nil
            if !context.save(&error) {
                abort()
            }
        }
    }
    
    
    //MARK: ShoppingCarTableViewCellDelegate
    func ShoppingCartTableViewCellDidTouchIncrease(cell: ShoppingCartTableViewCell, sender: AnyObject) {
        if(cell.numOfItem.text!.toInt()!  < 99){
        var increaseValue:NSNumber = cell.numOfItem.text!.toInt()! + 1
        cell.numOfItem.text = increaseValue.stringValue
        cell.updateNumOfItemWithShoppingcart(cell)
        }
    }
    
    func ShoppingCartTableViewCellDidTouchDecrease(cell: ShoppingCartTableViewCell, sender: AnyObject) {
        if(cell.numOfItem.text!.toInt()!  > 1){
        var increaseValue:NSNumber = cell.numOfItem.text!.toInt()! - 1
        cell.numOfItem.text = increaseValue.stringValue
        cell.updateNumOfItemWithShoppingcart(cell)
        }
    }
    
}
