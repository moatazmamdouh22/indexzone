//
//  HomeVC.swift
//  Indexzone
//
//  Created by MacBook on 1/18/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeVC: UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate,UISearchBarDelegate,UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var searchData : [SearchResult] = []
    var selectedPlace : SearchResult?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.isHidden = true
        self.tableView.isHidden = true
        searchBar.layer.borderWidth = 1.0
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.barTintColor = UIColor(hexString: "c9c9c9")
        searchBar.backgroundColor = UIColor.clear
        let textField = searchBar.value(forKey: "_searchField") as? UITextField
        textField?.textColor = UIColor.black
        textField?.font = UIFont(name: "Cairo-Regular", size: 18.0)
        textField?.backgroundColor = UIColor(hexString: "c9c9c9")
        textField?.placeholder = "Search_bar_title".localized
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        for place in MAPPLACE {
            let marker = GMSMarker()
            marker.userData = place._id
            marker.title = place._id
            marker.appearAnimation = GMSMarkerAnimation.pop
            
            marker.position = CLLocationCoordinate2D(latitude: place.lat!, longitude: place.lang!)
            let imageUrlString = place.logo
            if  imageUrlString == "default" || imageUrlString == "" || imageUrlString == "Default"{
                marker.snippet = "Tap the ↱ Navigate button to start navigating."
                marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0)
                marker.icon = UIImage(named: "marker") //Set marker icon here
                marker.map = self.mapView // Mapview here
                
            }
            else{
//                let url = URL(string: imageUrlString!)
//                let imageData = try! Data(contentsOf: url!)
//                let image = UIImage(data: imageData)
//                let rect = CGRect(x: 0, y: 0, width: 30, height: 30)
//                UIGraphicsBeginImageContext(rect.size)
//                image?.draw(in: rect)
//                let picture1: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
//                UIGraphicsEndImageContext()
//                marker.icon = picture1
//                marker.map = mapView
                marker.snippet = "Tap the ↱ Navigate button to start navigating."
                marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0)
                marker.icon = UIImage(named: "marker") //Set marker icon here
                marker.map = self.mapView // Mapview here
                
            }
            
        }
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        UserDefaults.standard.set(marker.userData, forKey: "placeID")
        performSegue(withIdentifier: "mapplace", sender: nil)
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableSearch
        cell.TitleAR.text = searchData[indexPath.row].titleAr
        cell.TitleEN.text = searchData[indexPath.row].titleEN
        // cell.Title = searchData[indexPath.row].titleAr
        // cell.detailTextLabel?.text = searchData[indexPath.row].titleEN
        cell.accessoryType = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.accessoryType = .none
            selectedPlace = nil
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            let place = self.searchData[indexPath.row]
            selectedPlace = searchData[indexPath.row]
            self.searchBar.endEditing(true)
            self.tableView.isHidden = true
            self.tableView.isHidden = true
            UserDefaults.standard.set(place.id!, forKey: "zoneplace")
            UserDefaults.standard.set(place.titleEN!, forKey: "titleEN")
            UserDefaults.standard.set(place.titleAr!, forKey: "titleAR")
            performSegue(withIdentifier: "mySegue", sender: nil)
            searchBar.text = ""
            
        }
    }
    
    //Fires when the user Allow/Doesn't allow the permission of getting the current location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    //Get the user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            //Setup the map camera
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 12, bearing: 0, viewingAngle: 0)
            
            UserDefaults.standard.set(location.coordinate.latitude, forKey: "CurrentLatitude")
            UserDefaults.standard.set(location.coordinate.longitude, forKey: "CurrentLonitude")
            
            locationManager.stopUpdatingLocation()
        }
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            self.searchData = []
            self.tableView.reloadData()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        WebServices.instance.searchForPlaces(searchText:searchText) { (data) in
            self.searchData = data
            self.tableView.reloadData()
            self.tableView.isHidden = false
            if searchText == ""{
                self.tableView.isHidden = true
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        if searchBar.text == "" {
            self.view.endEditing(true)
        }else{
            self.view.endEditing(true)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = false
        //  UIView.animate(withDuration: 0.8) {
        //     self.searchView.alpha = 0
        //   }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "23C9B8")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        self.tabBarController?.tabBar.shadow = true
        self.tabBarController?.tabBar.barTintColor = UIColor(hexString: "23C9B8")
        self.tabBarController?.tabBar.tintColor = .white
        self.navigationItem.title = "Home".localized
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

