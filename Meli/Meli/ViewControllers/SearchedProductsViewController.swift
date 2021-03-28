//
//  SearchedProductsViewController.swift
//  Meli
//
//  Created by Vanesa Mizrahi on 24/03/2021.
//

import UIKit

class SearchedProductsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    var query:String?
    var products: [Product] = []
    
    let network: NetworkManager = NetworkManager.sharedInstance

    
    @IBOutlet weak var resultProductsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultProductsCollectionView.delegate = self
        resultProductsCollectionView.dataSource = self
        loadProducts()
        createSpinnerView()
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
        
        
        let width = (resultProductsCollectionView.frame.size.width - 50 ) / 2
        let layout = resultProductsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width*2)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        resultProductsCollectionView.contentInset = UIEdgeInsets(top: 10, left: 00, bottom: 60, right: 00)
        
      }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultadoCell", for: indexPath) as! SearchedProductsCollectionViewCell
        
        let product = products[indexPath.row]
        cell.setupWith(product)
        
        if indexPath.row == products.count - 15 {
            loadNextPage()
        }
    
        return cell
        
    }
    
    
    func loadProducts(){
        let service = MeliService()
        service.Searchproduct(query: query!, offset: 0) { (products) in
            self.products = products
            self.resultProductsCollectionView.reloadData()
        }
    }
    
    func loadNextPage(){
        NetworkManager.isUnreachable { _ in
            self.showOfflinePage()
        }
        
        self.activityIndicator.startAnimating()
        let service = MeliService()
        service.Searchproduct(query: query!, offset: products.count) { (products) in
            self.products.append(contentsOf: products)
            self.resultProductsCollectionView.reloadData()
        }
        
        let elapsed = 0.0
        let delay = max(0.0, 1.0 - elapsed)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let destination = storyboard?.instantiateViewController(withIdentifier: "ProductDetail") as? ProductDetailTableViewController {
            destination.theProduct = products[indexPath.item]
            navigationController?.show(destination, sender: self)
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
    
    private func showOfflinePage() -> Void {
        DispatchQueue.main.async {
            if let destination = self.storyboard?.instantiateViewController(withIdentifier: "OfflineVC") as? OfflineViewController {
                self.navigationController?.show(destination, sender: self)
            }
        }
    }
    

}




