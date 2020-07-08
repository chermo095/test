//
//  CoffeeShopList.swift
//  CoffeeShop
//
//  Created by Аслан Аздаев on 17.06.2020.
//  
//

import Foundation
import UIKit


struct CoffeeShopList {
    let name: String
    let shopImage: UIImage?
    let position: Int
    
}

struct Category {
    let name: String
    let categoryImage: UIImage?
    let position: Int
}

struct SelectedMenu {
    let name: String
    let price: Int
    let description: String
    let category: String
    let position: Int
    var image: UIImage?
    let variation: [String: Int]?
}

