//
//  OfflineViewController.swift
//  Meli
//
//  Created by Vanesa Mizrahi on 24/03/2021.
//

import UIKit

class OfflineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func reintentarButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
