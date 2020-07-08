//
//  CoffeeShopCell.swift
//  CoffeeShop
//
//  Created by Аслан Аздаев on 17.06.2020.
//  
//

import UIKit

class CoffeeShopCell: UITableViewCell {

    @IBOutlet var listBubble: UIView!
    @IBOutlet var shopImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shopImage.layer.cornerRadius = shopImage.frame.size.height / 5
        backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
