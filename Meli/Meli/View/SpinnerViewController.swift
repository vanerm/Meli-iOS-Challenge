//
//  SpinnerViewController.swift
//  Meli
//
//  Created by Vanesa Mizrahi on 22/03/2021.
//

import UIKit
import NVActivityIndicatorView

class SpinnerViewController: UIViewController {
    
//    var spinner = UIActivityIndicatorView(style: .large)
    var spinner = NVActivityIndicatorView(frame: CGRect(x: 50, y: 50, width: 60, height: 60))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.type = NVActivityIndicatorType.circleStrokeSpin
        view = UIView()
        view.backgroundColor = UIColor(named: "BackgroundMeli")
//        spinner.color = UIColor(named: "AzulMeli") ?? .blue
        spinner.color = UIColor.getRandomColor()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
}

extension UIColor {
    
    class func getRandomColor() -> UIColor {
        
        let amarilloMeli = UIColor(named: "AmarilloMeli") ?? .yellow
        let azulMeli = UIColor(named: "AzulMeli") ?? .blue
        
        let colors = [amarilloMeli, azulMeli]
        let randomNumber = arc4random_uniform(UInt32(colors.count))
        
        return colors[Int(randomNumber)]
    }
    
}


