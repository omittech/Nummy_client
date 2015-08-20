//
//  MainMenuTableViewController.swift
//  Nummy_1
//
//  Created by Cheng Sun on 2015-07-25.
//  Copyright (c) 2015 Cheng Sun. All rights reserved.
//

import Foundation


class MainMenuTableViewController : UITableViewController {
    
    
    @IBOutlet weak var MenuDidTouch: UIBarButtonItem!
    
    
    @IBAction func ShoppingcartDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("ShoppingcartSegueFromMainMeun", sender: self)
    }

    
    var TableArray = [String]()
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        
        TableArray = ["Hello","Second","World"]
        MenuDidTouch.target = self.revealViewController()
        MenuDidTouch.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //Set Bar color
        self.navigationController!.navigationBar.barTintColor = UIColorFromRGB(0xEAA32F)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurant.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell") as! MainMenuTableViewCell
        
        let data = restaurant[indexPath.row]
        cell.configureWithMainMenu(data)
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow();
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell?;
        
        performSegueWithIdentifier("RestaurantDetailSegue", sender: currentCell)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RestaurantDetailSegue" {
            let toView = segue.destinationViewController as! RestaurantViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            toView.detail = restaurant[indexPath.row]
            
        }
    }


    
    
}