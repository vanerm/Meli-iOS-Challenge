//
//  SearchViewController.swift
//  Meli
//
//  Created by Vanesa Mizrahi on 17/03/2021.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let network: NetworkManager = NetworkManager.sharedInstance
    
    @IBOutlet var searchBarView: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.titleView = searchBarView
        searchBarView.delegate = self
        searchBarView.backgroundColor = UIColor(named: "AmarilloMeli")
        searchBarView.placeholder = "Buscar en Mercado Libre"
        searchBarView.searchTextField.backgroundColor = .white
        searchBarView.searchTextField.textColor = .black

        self.tabBarController?.tabBar.layer.borderWidth = 0.3
        self.tabBarController?.tabBar.clipsToBounds = true
        
        NetworkManager.isUnreachable { _ in
            self.showOfflinePage()
        }
        
    }

    
    // Metodos del SearchBarDelegate
    
    // Este metodo se ejecuta cuando el usuario toca el boton de cancel
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = false
        return true
    }
    
        func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.showsCancelButton = true
            return true
        }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    
    //Cuando el usuario toca el boton del search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        if let searchText = searchBarView.text, searchText.count > 1 {
            searchBarView.resignFirstResponder()
            performSegue(withIdentifier: "goToCollection", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SearchedProductsViewController{
            destination.query = searchBarView.text
        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        NetworkManager.isUnreachable { _ in
            self.showOfflinePage()
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
