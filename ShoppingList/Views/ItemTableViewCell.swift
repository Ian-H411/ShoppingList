//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Ian Hall on 8/9/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

/* gameplan for this specific file
 
 1.iboutlets - complete
 2.update button helper function - complete
 3.ibactions - complete
 4.extension with update func -complete
 5.protocol func --complete
 
 */

import UIKit
//protocol to be called in itemlisttableview
protocol ItemTableViewCellDelegate: class {
    func cellSettingHasChanged(_ sender: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {
    
    //displays name of item
    @IBOutlet weak var ItemNameTextField: UILabel!
    
    //dynamic magic button that changes when tapped
    @IBOutlet weak var purchasedButton: UIButton!
    
    //my job posting that we will set  itemlistableviecontroller to
    weak var delegate: ItemTableViewCellDelegate?
    
    //this func updates my buttons image
    func updateButton(isPurchased: Bool){
        let imageName = isPurchased ? "complete" : "inComplete"
        purchasedButton.setImage(UIImage(named: imageName), for: .normal)
    }
    //this guy will yell at my table view that something has changed
    @IBAction func purchasedButtonTapped(_ sender: UIButton) {
        delegate?.cellSettingHasChanged(self)
    }

}
//extension to update items
extension ItemTableViewCell {
    func update(item: Item){
        ItemNameTextField.text = item.name
        updateButton(isPurchased: item.purchased)
}
}
