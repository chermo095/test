//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  
//
import Foundation
import UIKit
import Firebase

class CoffeeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    var coffeeShopLists: [CoffeeShopList] = []
    var sortedShopLists: [CoffeeShopList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        title = "Грозный.Еда"
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action:#selector(handleLogout))

        tableView.register(UINib(nibName: "CoffeeShopCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        loadShops()
        
    }
    
   @objc func handleLogout() {
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        navigationController?.popToRootViewController(animated: true)
    }
    
    func getFoto (named: String, position: Int) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagePath = storageRef.child("CoffeeShops/\(named).jpg")
        imagePath.getData(maxSize: 1 * 1024 * 1024) {data, error in
        if let error = error {
            print(error)
        } else {
             if let image = UIImage(data: data!) {
                let newList = CoffeeShopList(name: named, shopImage: image, position: position)
                self.coffeeShopLists.append(newList)
                self.sort()
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            }

           }
          
        }
    }
   
    func loadShops () {
        
        db.collection("coffeeShop").order(by:"position").addSnapshotListener { (querySnapshot, error) in
            
            self.coffeeShopLists = []
            if let e = error {
                print("Error\(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        print(doc.data())
                        if let shop = data["name"] as? String, let position = data["position"] as? Int {
                                self.getFoto(named: shop, position: position)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func sort () {
        sortedShopLists = coffeeShopLists.sorted {$0.position < $1.position}
    }
    
}



extension CoffeeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeShopLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CoffeeShopCell
        cell.shopImage.image = sortedShopLists[indexPath.row].shopImage
        return cell
    }
    
    
}

extension CoffeeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if let vc = storyboard?.instantiateViewController(withIdentifier: "ShopMenu") as? CategoryMenuViewController {
           // 2: success! Set its selectedImage property
        vc.shopName = sortedShopLists[indexPath.row].name
//        print(vc.shopName)
           // 3: now push it onto the navigation controller
           navigationController?.pushViewController(vc, animated: true)
       }
        
    }
}
    

    
