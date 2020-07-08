//
//  MenuCollectionViewCell.swift
//  CoffeeShop
//
//  Created by Аслан Аздаев on 19.06.2020.
//  
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageOfGood: UIImageView!
    @IBOutlet weak var nameOfGood: UILabel!
    @IBOutlet weak var priceOfGood: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageOfGood.layer.cornerRadius = 10
        imageOfGood.translatesAutoresizingMaskIntoConstraints = true
        imageOfGood.contentMode = .scaleAspectFill
        imageOfGood.clipsToBounds = true
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
