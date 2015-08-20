//
//  Hello.swift
//  Nummy_1
//
//  Created by Cheng Sun on 2015-07-25.
//  Copyright (c) 2015 Cheng Sun. All rights reserved.
//

import UIKit
import CoreData

class RestaurantViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, RestaurantCollectionViewCellDelegate {
    
    var detail: JSON!
    var items : JSON!

    @IBOutlet weak var restaurant_name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var shoppingcart: SpringButton!
    @IBOutlet weak var restaurant_image: UIImageView!
    
    
    override func viewDidLoad() {
        
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        //Set Bar color
        self.navigationController!.navigationBar.barTintColor = UIColorFromRGB(0xEAA32F)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        items = detail["items"]
        restaurant_name.text = detail["name"].string
        address.text = detail["address"].string
        restaurant_image.image = UIImage(named: detail["picture"].string!)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        var size = collectionView.bounds.size       // size of collection view
        
        switch size.width
        {
        case 300:
            return CGSize(width: 145, height: 180)
        case 355:
            return CGSize(width: 170, height: 210)
        case 394:
            return CGSize(width: 190, height: 230)
        default:
            return CGSize(width: 140, height: 180)      // in case there is no size
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count + 1
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCell", forIndexPath: indexPath) as! RestaurantCollectionViewCell
        println(indexPath.row)
        let data = items[indexPath.row]
        cell.configureWithItems(data)
        
        cell.delegate = self

        return cell
    }
    

    @IBAction func ShoppingcartDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("ShoppingcartSegue", sender: self)
    }
    
    //MARK: RestaurantCollectionViewCellDelegate
    
    func RestaurantTableViewAddItemDidTouch(cell: RestaurantCollectionViewCell, sender: AnyObject) {
        //TODO
        shoppingcart.animation = "pop"
        shoppingcart.force = 1
        shoppingcart.animate()
        
        //let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
  /*      var tepm = cell.itemname.text
        
        var appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        var Item = NSEntityDescription.insertNewObjectForEntityForName("Items", inManagedObjectContext: context) as! NSManagedObject
        
        var request = NSFetchRequest(entityName: "Items")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "name = %@", cell.itemname.text!)

        var results = context.executeFetchRequest(request, error: nil)
        
        if results!.count > 0 {
            for result：AnyObject in results! {
               //TODO 
               // Update the Item amount
            }
        }
        
        else {
        Item.setValue(cell.itemname.text, forKey: "name")
        Item.setValue(cell.price.text, forKey: "price")
        Item.setValue(1, forKey: "amount")
        }
        
        context.save(nil)
        
        println(results)  */
        
        
        //Reference to our app delegate
        var appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        let entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: context)
        
        var request = NSFetchRequest(entityName: "Item")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "name = %@", cell.itemname.text!)
        var results = context.executeFetchRequest(request, error: nil)
        
        if results!.count > 0 {
            for result : AnyObject in results! {
                if let name: String = result.valueForKey("name") as? String {
                    var price: String = result.valueForKey("price") as! String
                    var amount: NSNumber = result.valueForKey("amount") as! NSNumber
                    amount = Int(amount) + 1
                    result.setValue(amount, forKey: "amount")
                }
                
            }
        }
        else {
            var newItem = ItemModel(entity: entity!, insertIntoManagedObjectContext: context)
            
            newItem.name = cell.itemname.text!
            newItem.price = cell.price.text!
            newItem.amount = 1
        }
        context.save(nil)
    }
    
}






















