//
//  MenuCollectionViewController.swift
//  CoffeeShop
//
//  Created by Аслан Аздаев on 19.06.2020.
//  
//

import UIKit
import Firebase


class MenuCollectionViewController: UIViewController {
    
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var shopName: String = ""
    var selectedCategory: String = ""
    var defaultImage: UIImage! = UIImage(named: "MeAvatar")
    let db = Firestore.firestore()
    
    var selectedMenu: [SelectedMenu] = []
    var sortedMenu: [SelectedMenu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        // self.clearsSelectionOnViewWillAppear = false
        // Register cell classes
        collectionView.register(UINib(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")

       loadMenu(from: shopName)
    }
    
    func loadMenu (from menu: String ) {
            selectedMenu = []
            db.collection("\(menu)Menu").getDocuments { (querySnapshot, error) in
                if let e = error {
                    print("Error\(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            print(doc.data())
                            if let good = data["name"] as? String, let category = data["category"] as? String, let position = data["position"] as? Int,let description = data["description"] as? String, let sale = data["sale"] as? Bool, let price = data["price"] as? Int, let variation = data["variation"] as? [String: Int] {
                                if category == self.selectedCategory { // выгрузка только нужной категории товаров
                                    let newList = SelectedMenu (name: good, price: price, description: description, category: category, position: position, image: nil, variation: variation)
                                    self.selectedMenu.append(newList)
                                    self.getFoto(named: good)
                                }
                                print(self.selectedMenu)
//                                DispatchQueue.main.async {
//                                    self.collectionView.reloadData()
//                                }
                            }
                        }
                    }
                }
            }
        }
    
    func getFoto (named: String) {
         let storage = Storage.storage().reference().child("\(shopName)Menu/\(named).jpg")
         storage.getData(maxSize: 1 * 1024 * 1024) {data, error in
         if let error = error {
             print(error)
         } else {
              if let image = UIImage(data: data!) {
                if let index = self.selectedMenu.index(where: { $0.name == named }) {
                    self.selectedMenu[index].image = image
                    print(self.selectedMenu)
                }
                 DispatchQueue.main.async {
                 self.collectionView.reloadData()
                 }
             }

            }
           
         }
     }
    
    func sort () {
           sortedMenu = selectedMenu.sorted {$0.position < $1.position}
       }
    


}

extension MenuCollectionViewController: UICollectionViewDataSource {
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return selectedMenu.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath as IndexPath) as! MenuCollectionViewCell
        // Configure the cell
        if selectedCategory == selectedMenu[indexPath.row].category {
            cell.imageOfGood.image = selectedMenu[indexPath.row].image ?? defaultImage
            cell.priceOfGood.text = String(selectedMenu[indexPath.row].price) + " р."
            cell.nameOfGood.text = selectedMenu[indexPath.row].name
            return cell
        } else {
            return cell
        }
    }
}
    // MARK: UICollectionViewDelegate
extension MenuCollectionViewController: UICollectionViewDelegate {
    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "showDetails") as? DetailsViewController {
            vc.selectedImage = selectedMenu[indexPath.row].image
            vc.selectedDetails = selectedMenu[indexPath.row].description
            vc.selectedPrice = String(selectedMenu[indexPath.row].price) + " р."
            vc.selectedName = selectedMenu[indexPath.row].name
            vc.selectedVariation = selectedMenu[indexPath.row].variation
            present(vc, animated: true, completion: nil)
//            navigationController?.pushViewController(vc, animated: true)
            }
        print(indexPath.row)
    }
    
    
    
}
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

