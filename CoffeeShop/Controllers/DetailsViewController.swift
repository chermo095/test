//
//  DetailsViewController.swift
//  CoffeeShop
//
//  Created by Аслан Аздаев on 27.06.2020.
//  
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var variation: AutoSizingTableView!
    
    
    var selectedImage: UIImage?
    var selectedName: String?
    var selectedPrice: String?
    var selectedDetails: String?
    var selectedVariation: [String: Int]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        variation.delegate = self
        variation.dataSource = self
        variation.invalidateIntrinsicContentSize()
//        view.frame.size = variation.intrinsicContentSize
        variation.reloadData()
        details.frame.size = self.details.intrinsicContentSize
//        view.setNeedsLayout()
//        view.layoutIfNeeded()
//        variation.layoutIfNeeded()
//        variation.frame.size = variation.intrinsicContentSize
//        variation.translatesAutoresizingMaskIntoConstraints = false
        variation.rowHeight = UITableView.automaticDimension
        variation.isScrollEnabled = true
        variation.isHidden = false
        buttonAdd.layer.cornerRadius = 5
        view.layer.cornerRadius = 20
        view.clipsToBounds = false
        image.layer.cornerRadius = 20
        image.image = selectedImage
        name.text = selectedName
        price.text = selectedPrice
        details.text = selectedDetails
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        for key in Array(arrayLiteral: selectedVariation?.keys) {
            print(key ?? "100")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedVariation?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Variation", for: indexPath)
        var keysArray: [String] = []
        var valueArray: [Int] = []
        for (key, value) in selectedVariation!.sorted(by: {$0.1 < $1.1}) {
            keysArray.append(key)
            valueArray.append(value)
        }
        cell.textLabel?.text = keysArray[indexPath.row]
        cell.detailTextLabel?.text = "+" + String(valueArray[indexPath.row]) + " р."
        return cell
        }
}

class AutoSizingTableView: UITableView {
    
      override var intrinsicContentSize: CGSize {
          self.layoutIfNeeded()
          return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
      }
      
      override var contentSize: CGSize {
          didSet{
              self.invalidateIntrinsicContentSize()
          }
      }
      
      override func reloadData() {
          super.reloadData()
          self.invalidateIntrinsicContentSize()
      }
    
  }

