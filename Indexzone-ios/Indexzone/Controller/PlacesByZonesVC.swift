//
//  PlacesByZonesVC.swift
//  Indexzone
//
//  Created by MacBook on 3/8/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class PlacesByZonesVC: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var searchbar1: UITextField!
    @IBOutlet weak var searchbar2: UISearchBar!
    @IBOutlet weak var fView: UIView!
    var categoryID = ""
    var placeID = UserDefaults.standard.value(forKey: "zoneplace") as! String
    var titleEN = UserDefaults.standard.value(forKey: "titleEN") as! String
    var titleAR = UserDefaults.standard.value(forKey: "titleAR") as! String

    var userPlaces : [Places] = []
    var currentLat = UserDefaults.standard.value(forKey: "CurrentLatitude")
    var currentLang = UserDefaults.standard.value(forKey: "CurrentLonitude")

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        searchbar2.layer.borderWidth = 1.0
        searchbar2.layer.borderColor = UIColor.lightGray.cgColor
        
        searchbar2.barTintColor = UIColor(hexString: "c9c9c9")
        searchbar1.backgroundColor = UIColor.clear
        searchbar1.layer.borderWidth = 1.0
        searchbar1.layer.borderColor = UIColor.lightGray.cgColor
        
        searchbar1.backgroundColor = UIColor.clear

        searchbar1.textColor = UIColor.black
        searchbar1.font = UIFont(name: "Lalezar-Regular", size: 18.0)
        searchbar1.backgroundColor = UIColor(hexString: "c9c9c9")
        let textField2 = searchbar2.value(forKey: "_searchField") as? UITextField
        textField2?.textColor = UIColor.black
        textField2?.font = UIFont(name: "Lalezar-Regular", size: 18.0)
        textField2?.backgroundColor = UIColor(hexString: "c9c9c9")
        searchbar1.isUserInteractionEnabled = false
        if APPLANGUAGE == "ar"{
        searchbar1.placeholder = titleAR
        }else{
            searchbar1.placeholder = titleEN
        }
        searchbar2.placeholder = "searchwith".localized
        super.viewDidLoad()
        WebServices.instance.getplacebyzone(ZoneID: placeID) { (data) in
            self.userPlaces = data
            self.collectionView.reloadData()
            print(self.userPlaces.count)
        }
            
        print("placeID",placeID)
        print("title",titleEN)

    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PlaceCollection
        let place = self.userPlaces[indexPath.row]
        if let urlPath = place.logoPath{
            let placePhoto = URL(string:"\(urlPath)")
            cell.logoPic.sd_setImage(with: placePhoto)
        }
        cell.placeDescription.text = place.categoryID
        cell.placeTitle.text = place.titlename
        cell.totalfav.text = place.totalFav
        cell.totalrate.text = place.rate
        cell.totalView.text = place.totalwatch
     //   cell.rating.rating = place.totalRate!
        // get distance
        let url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=\(currentLat!),%20\(currentLang!)&destinations=\((place.lat)!),%20\((place.lang)!)&key=AIzaSyBt0SPuI_OPVc4TzUogoQ7yRZ5Rs6hMgv4"
        
        Alamofire.request(url, method: .get , encoding: URLEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                print("URL",url)
                let json = JSON(value)
                print("All Value",json)
                let rows = json["rows"]
                for (_, subJson) in rows {
                    let element = subJson["elements"]
                    print("asdasdasdasd",element)
                    for (_, subJson) in element {
                        let Distance = subJson["distance"]
                        cell.distance.text = Distance["text"].stringValue
                        print("Distance is -->" , cell.distance)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let place = self.userPlaces[indexPath.row]
        UserDefaults.standard.set(place._id!, forKey: "placeID")

        performSegue(withIdentifier: "collectionsegue", sender: nil)
    }
    //Space between rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    //Space between items in the same row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    //Size of each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numOfCells : CGFloat = 2.0
        let paddingSpace : CGFloat = 10.0 * (numOfCells + 1.0 )
        let availableWidth = self.view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: 200)
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            self.collectionView.reloadData()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        WebServices.instance.filterbyname(searchText: searchText, zoneID: placeID) { (data) in
            self.userPlaces = data
            self.collectionView.reloadData()
        }
        if searchText == ""{
            self.collectionView.reloadData()
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
    }

    @IBAction func filter(_ sender: Any) {
        fView.isHidden = false
    }
    @IBAction func closefView(_ sender: Any) {
        fView.isHidden = true
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APPCATEGORIES.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let place = APPCATEGORIES[indexPath.row]
        if APPLANGUAGE == "ar"{
            cell.textLabel?.text = place.titleAR!
        }else{
            cell.textLabel?.text = place.titleEN!
        }
        self.categoryID = place.id!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        WebServices.instance.filterbycategory(categoryID: categoryID, zoneID: placeID) { (data) in
            self.userPlaces = data
            self.collectionView.reloadData()
        }
        fView.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "23C9B8")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        self.tabBarController?.tabBar.shadow = true
        self.tabBarController?.tabBar.barTintColor = UIColor(hexString: "23C9B8")
        self.tabBarController?.tabBar.tintColor = .white
            self.navigationItem.title = "Search".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

}
