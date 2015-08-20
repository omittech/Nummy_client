//
//  OrderSummaryViewController.swift
//  Nummy
//
//  Created by Cheng Sun on 2015-07-29.
//  Copyright (c) 2015 Cheng Sun. All rights reserved.
//

import UIKit

class OrderSummaryViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate, UIPickerViewDataSource,UIPickerViewDelegate, ShoppingCartTableViewCellDelegate {

    
    @IBOutlet weak var textfieldSelect: UITextField!
    
    @IBOutlet weak var picker: UIPickerView! = UIPickerView()
    var arr = ["12/15-2:00PM", "12/15-2:30PM", "12/15-3:00PM"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldSelect.delegate = self
        picker.delegate = self
        picker.hidden = true
        textfieldSelect.text = arr[0]
        
        
    }
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arr.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return arr[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        textfieldSelect.text = arr[row]
        picker.hidden = true;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("order_cart") as! ShoppingCartTableViewCell
        cell.delegate = self
        var myCart: AnyObject = cell.getAllItemsInShoppingCart()
        cell.configureWithShoppingcart(myCart[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cell = tableView.dequeueReusableCellWithIdentifier("order_cart") as! ShoppingCartTableViewCell
        cell.delegate = self
        var myCart: AnyObject = cell.getAllItemsInShoppingCart()
        return myCart.count
    }


    //MARK ShoppingCarTableViewCellDelegate
    
    func ShoppingCartTableViewCellDidTouchDecrease(cell: ShoppingCartTableViewCell, sender: AnyObject) {
        //TODO
    }
    
    func ShoppingCartTableViewCellDidTouchIncrease(cell: ShoppingCartTableViewCell, sender: AnyObject) {
        //TODO
    }
    
//    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
//        picker.hidden = false
//        return false
//    }
    
    @IBAction func dorpdownDidTouch(sender: AnyObject) {
        picker.hidden = false
    }
    
}
