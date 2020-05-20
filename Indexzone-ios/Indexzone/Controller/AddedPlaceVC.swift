//
//  AddedPlaceVC.swift
//  Indexzone
//
//  Created by MacBook on 1/22/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import SDWebImage
import PKHUD
class AddedPlaceVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var userPlaces : [Places] = []
    
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
        return userPlaces.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddedPlace
        
        let place = self.userPlaces[indexPath.row]
        if place.titlename == "" || place.titlename == "default" || place.titlename == "Default"{
            cell.placetitle.text = "NoName".localized
        }
        else{
            
            cell.placetitle.text = place.titlename
        }
        
        cell.category.text = place.categoryID
        cell.addzone.text = place.zoneID
        cell.totalfav.text = place.totalFav
        cell.totalrate.rating = place.totalRate!
        cell.placeID = place._id!
        if place.logoPath == "" || place.logoPath == "default" || place.logoPath == "Default"{
            cell.placelogo.image = UIImage(named:"logo daleel neww-1")
        }
        else{
            if let urlPath = place.logoPath{
                let placePhoto = URL(string:"\(urlPath)")!
                cell.placelogo.sd_setImage(with: placePhoto)
            }
        }
        
        
        if place.status == 1{
            cell.statuscolor.backgroundColor = UIColor.green
        }else if place.status == 2{
            cell.statuscolor.backgroundColor = UIColor.blue
        }else if place.status == 3{
            cell.statuscolor.backgroundColor = UIColor.red
        }else if place.status == 0{
            cell.statuscolor.backgroundColor = UIColor.yellow
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = self.userPlaces[indexPath.row]
        UserDefaults.standard.set(place._id ?? "", forKey: "placeID")
        performSegue(withIdentifier: "mySegueID", sender: nil)
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    

    override func viewWillAppear(_ animated: Bool) {
        WebServices.instance.getplaces{ (data) in
            self.userPlaces = data
            self.tableView.reloadData()
            if self.userPlaces.count == 0{
                self.tableView.separatorStyle = .none
                AlertHandler().displayMyAlertMessage(message: "Their is No Added Places", title: "Attention".localized, okTitle: "ok", view: self)
            }else if self.userPlaces.count != 0{
                self.tableView.reloadData()
            }
            print(self.userPlaces.count)
        }
 self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "23C9B8")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        self.tabBarController?.tabBar.shadow = true
        self.tabBarController?.tabBar.barTintColor = UIColor(hexString: "23C9B8")
        self.tabBarController?.tabBar.tintColor = .white
        self.navigationItem.title = "ADDEDPLACE".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
    }
}

