//
//  ProductDetailTableViewController.swift
//  Meli
//
//  Created by Vanesa Mizrahi on 17/03/2021.
//

import UIKit
import Kingfisher

class ProductDetailTableViewController: UITableViewController {
    
    var theProduct: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        createSpinnerView()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath)

        if let aCell = cell as? ProductTableViewCell{
            aCell.setupWith(self.theProduct!)
        }

        return cell
    }
    
//    Share Nativo
    
    @IBAction func doShare(_ sender: Any) {
        
        if let product = theProduct, let url = URL(string: "\(product.permalink ?? "no link to share")"){
            let message = "\(product.title ?? "")"
           
            let activityVC = UIActivityViewController(activityItems: [message,url], applicationActivities: nil)
            present(activityVC, animated: true)
        }
    }
    
    
    func createSpinnerView() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    
  
}
