//
//  ShopMenuViewController.swift
//  CoffeeShop
//
//  Created by Аслан Аздаев on 18.06.2020.
//  
//

import UIKit
import Firebase

class CategoryMenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var shopName: String = ""
    
    let db = Firestore.firestore()
    
    var categorys: [Category] = []
    var sortedCategorys: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        title = "Категории"
        tableView.register(UINib(nibName: "CoffeeShopCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        loadCategory()
        // Do any additional setup after loading the view.
    }
    
    func getFoto (named: String, position: Int) {
        let storage = Storage.storage().reference().child("Category/\(named).jpg")
        storage.getData(maxSize: 1 * 1024 * 1024) {data, error in
        if let error = error {
            print(error)
        } else {
             if let image = UIImage(data: data!) {
                let newList = Category(name: named, categoryImage: image, position: position)
//                print(newList.name)
                self.categorys.append(newList)
                self.sort()
//                print(self.sortedCategorys)
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            }

           }
          
        }
    }
    
    
    func loadCategory () {
            categorys = []
            db.collection("category").getDocuments { (querySnapshot, error) in
                if let e = error {
                    print("Error\(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            print(doc.data())
                            if let shop = data["name"] as? String, let relevant = data["relevant"] as? Array<String>, let position = data["position"] as? Int {
//                                print(shop)
//                                print(relevant)
                                for relevantData in relevant {
                                    if self.shopName == relevantData {self.getFoto(named: shop, position: position)}}
    //                            выше код. выгрузка лишь нужной категории
//                                DispatchQueue.main.async {
//                                    self.tableView.reloadData()
//                                }
                            }
                        }
                    }
                }
            }
        }
    func sort () {
        sortedCategorys = categorys.sorted {$0.position < $1.position}
    }
    
    
    
    }

extension CategoryMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedCategorys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CoffeeShopCell
        cell.shopImage.image = sortedCategorys[indexPath.row].categoryImage
        return cell
    }

}

extension CategoryMenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if let vc = storyboard?.instantiateViewController(identifier: "toMenu") as? MenuCollectionViewController {
           // 2: success! Set its selectedImage property
        vc.shopName = shopName
        vc.selectedCategory = sortedCategorys[indexPath.row].name
           // 3: now push it onto the navigation controller
           navigationController?.pushViewController(vc, animated: true)
       }
        
    }
}

