//
//  LaunchViewController.swift
//  Meli
//
//  Created by Vanesa Mizrahi on 24/03/2021.
//

import UIKit

class LaunchViewController: UIViewController {

    let network: NetworkManager = NetworkManager.sharedInstance
        @IBOutlet weak var loadActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadActivityIndicator.startAnimating()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let elapsed = 0.0
        let delay = max(0.0, 0.0 - elapsed)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.loadActivityIndicator.stopAnimating()
            self.loadActivityIndicator.hidesWhenStopped = true
            // If the network is unreachable show the offline page
            NetworkManager.isUnreachable { _ in
                self.showOfflinePage()
                self.tabBarController?.title = "No hay internet"
            }
            NetworkManager.isReachable { _ in
                self.showMainPage()
            }
        }
        

    }
    
    private func showOfflinePage() -> Void {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "NetworkUnavailable", sender: self)
        }
    }
    
    private func showMainPage() -> Void {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "MainController", sender: self)
        }
    }
}
