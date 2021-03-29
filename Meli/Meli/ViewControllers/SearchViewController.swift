//
//  SearchViewController.swift
//  Meli
//
//  Created by Vanesa Mizrahi on 17/03/2021.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    
    let network: NetworkManager = NetworkManager.sharedInstance
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var geocoder: CLGeocoder?
    
    @IBOutlet var searchBarView: UISearchBar!
    @IBOutlet weak var locationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //CoreLocation
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        // Se solicita permiso al usuario para obtener posicion con CoreLocation
        locationManager?.requestAlwaysAuthorization()
        //Geocoder
        geocoder = CLGeocoder()
        currentLocation = locationManager?.location
        setupPosition()
        locationButton.setTitleColor(.gray, for: .normal)
        locationButton.tintColor = .gray
        
        //SearchBar
        navigationItem.titleView = searchBarView
        searchBarView.delegate = self
        searchBarView.backgroundColor = UIColor(named: "AmarilloMeli")
        searchBarView.placeholder = "Buscar en Mercado Libre"
        searchBarView.searchTextField.backgroundColor = .white
        searchBarView.searchTextField.textColor = .black
        
        self.tabBarController?.tabBar.layer.borderWidth = 0.3
        self.tabBarController?.tabBar.clipsToBounds = true
        
        //NetworkManager
        NetworkManager.isUnreachable { _ in
            self.showOfflinePage()
        }
        
    }
    
    // Cuando el usuario decide si otorga permisos o no (o si ya habia tomado la decision previamente)
    // se ejecuta este metodo, y por ese motivo debemos configurar el viewcontroller como delegate del manager
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        setupPosition()
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                    locationManager?.startUpdatingLocation()
                }
            }
        }
    }
    
    // Este metodo se ejecuta cada vez que se detecta un cambio de ubicacion
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        setupPosition()
    }
    
    // Core Location - How to Display a Human-Readable Address Using CLGeocoder
    func setupPosition() {
        currentLocation = locationManager?.location
        locationManager?.requestAlwaysAuthorization()
        if let theCurrentLocation = currentLocation{
            geocoder?.reverseGeocodeLocation(theCurrentLocation) { (placemarks, error) in
                // 1
                if let error = error {
                    print(error)
                }
                
                // 2
                guard let placemark = placemarks?.first else { return }
                print(placemark)
                
                // 3
                guard let streetNumber = placemark.subThoroughfare else { return }
                guard let streetName = placemark.thoroughfare else { return }
                guard let city = placemark.locality else { return }
//                guard let state = placemark.administrativeArea else { return }
//                guard let zipCode = placemark.postalCode else { return }
//                guard let country = placemark.country else { return }
                
                // 4
                DispatchQueue.main.async {
                    self.locationButton.setTitle("  Enviar a \(streetName) \(streetNumber), \(city)", for: .normal)
                }
            }
        } else {
            self.locationButton.setTitle("  Elegí dónde reicibir tus compras >", for: .normal)
        }
    }
    
    
    // Metodos del SearchBarDelegate
    // Este metodo se ejecuta cuando el usuario toca el boton de cancel
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
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
    
    // Network Manager
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
    
//    Button Setup Posicion para acceder a la configuracion del sistema cuando el acceso a la localizacion esta seteada en nunca
    @IBAction func setupPosition(_ sender: Any) {
        
        if currentLocation == nil {
            let alertController = UIAlertController (title: "Ubicación", message: "Si desea permitir acceso a su ubicación, debe modificar la configuración del sistema", preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Configuración", style: .default) { (_) -> Void in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
}
