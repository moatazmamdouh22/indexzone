//
//  FavoriteVC.swift
//  Indexzone
//
//  Created by MacBook on 1/21/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import SDWebImage
import PKHUD
class FavoriteVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    var userPlaces : [Favorite] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if skip == nil {
            return userPlaces.count
        }
        else{
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoritePlaces
        let place = self.userPlaces[indexPath.row]
        print("PlaceeeeeeeData")
        print(place)
        cell.placetitle.text = place.titlename!
        cell.category.text = place.categoryID
        cell.addzone.text = place.zoneID
        cell.totalfav.text = place.totalFav
        cell.totalrate.rating = place.totalRate!
        cell.placeID = place._id!
//        if let urlPath = place.logoPath{
//            let placePhoto = URL(string:"\(urlPath)")
//            cell.placelogo.sd_setImage(with: placePhoto)
//        }
        if place.logoPath == "" || place.logoPath == "default" || place.logoPath == "Default"{
            cell.placelogo.image = UIImage(named:"logo daleel neww-1")
        }
        else{
            if let urlPath = place.logoPath{
                let placePhoto = URL(string:"\(urlPath)")!
                cell.placelogo.sd_setImage(with: placePhoto)
            }
        }
        if skip == nil {
          return cell
        }
        else{
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = self.userPlaces[indexPath.row]
        UserDefaults.standard.set(place._id!, forKey: "placeID")
        UserDefaults.standard.removeObject(forKey: "latitplace")
        UserDefaults.standard.removeObject(forKey: "langitplace")
        performSegue(withIdentifier: "mySeguID", sender: nil)
    }    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func viewWillAppear(_ animated: Bool) {
        if skip != nil {
            self.displaySkipAlert(message: "accessFavorite".localized, title: "Attention".localized)
        }
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "23C9B8")
        WebServices.instance.Allfavplaces{ (data) in
            self.userPlaces = data
            self.tableView.reloadData()
            if self.userPlaces.count == 0{
                self.tableView.separatorStyle = .none
                AlertHandler().displayMyAlertMessage(message: "TheirisNoFavoritePlaces".localized, title: "Attention".localized, okTitle: "ok".localized, view: self)
                
            }else if self.userPlaces.count != 0{
                self.tableView.reloadData()
            }

            print(self.userPlaces.count)
        }

        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        self.tabBarController?.tabBar.shadow = true
        self.tabBarController?.tabBar.barTintColor = UIColor(hexString: "23C9B8")
        self.tabBarController?.tabBar.tintColor = .white
        self.navigationItem.title = "FAVORITE".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
    }
}

