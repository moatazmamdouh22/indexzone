//
//  PlaceInfoVC.swift
//  Indexzone
//
//  Created by MacBook on 2/28/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import SwiftyJSON
import PKHUD
import Cosmos
class PlaceInfoVC: UIViewController {
    
    @IBOutlet weak var emailwtsapp: UILabel!
    @IBOutlet weak var imageselect: UIImageView!
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var adddescription: UILabel!
    @IBOutlet weak var addzone: UILabel!
    @IBOutlet weak var logopic: CircularImage!
    @IBOutlet weak var totalfav: UILabel!
    @IBOutlet weak var favicon: UIButton!
    @IBOutlet weak var faceshow: UIButton!
    @IBOutlet weak var instgramshow: UIButton!
    @IBOutlet weak var whatsappshow: UIButton!
    @IBOutlet weak var yoytubeshow: UIButton!
    @IBOutlet weak var websiteshow: UIButton!
    @IBOutlet weak var emailshow: UIButton!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var contactlabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var totalrate = 0
     var str = "http://139.59.158.10:7000/uploadFiles/upload_6abb94df3042319ee2b296e28f39be65.jpg"
    var placeID = UserDefaults.standard.value(forKey: "placeID") as! String

    let url = APIKeys().GET_PLACE_ID
    var phNo = ""
    var cantap:Bool = false
    var facebook = ""
    var instgram = ""
    var youtube = ""
    var website = ""
    var email = ""
    var whatsapp = ""
    var images :[String] = ["","","","","",""]
    var localSource = [InputSource]()

    var userPlaces = PlacesInfo()
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBAction func facebook(_ sender: Any) {
        let url = URL(string: "https://\(facebook)")
        if url != nil{
        UIApplication.shared.open(url!)
        }
        }
    
    @IBAction func website(_ sender: Any) {
        let url = URL(string: "https://\(website)")
        if url != nil{
            UIApplication.shared.open(url!)
        }

    }
    @IBAction func instgram(_ sender: Any) {
        let url = URL(string: "https://\(instgram)")
        if url != nil{
            UIApplication.shared.open(url!)
        }
    }
    @IBAction func youtube(_ sender: Any) {
        let url = URL(string: "https://\(youtube)")
        if url != nil{
            UIApplication.shared.open(url!)
        }
    }
    @IBAction func whatsapp(_ sender: Any) {
        if let phoneUrl = URL(string: "telprompt:\(whatsapp)")
        {
            print(phoneUrl)
            UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
        }


    }
    
    @IBAction func emailbtn(_ sender: Any) {
        let email = self.email
        if let url = URL(string: "mailto:\(email)") {
            print(url)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        

    }
    
    @IBAction func call(_ sender: Any) {
        if let phoneUrl = URL(string: "telprompt:\(phNo)")
        {
            print(phoneUrl)
            UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
    }
    }
    override func viewWillAppear(_ animated: Bool) {
        contactlabel.text = "contact".localized
        self.cantap = false
        self.images = [String](arrayLiteral: "","","","","","")
        self.localSource = [InputSource]()
        //self.indicator.show()
        HUD.show(.progress)

        Alamofire.request("\(url)?id=\(placeID)", method: .get , encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                HUD.hide()
                print("\(self.url)?id=\(self.placeID)")
                let json = JSON(value)
                print("All places",json)
                if let category  = json["categoryID"].dictionary{
                    if APPLANGUAGE == "ar"{
                        self.category.text = category["titleAr"]?.string
                    }else{
                        self.category.text = category["titleEN"]?.string
                    }
                    
                }
                if let zone  = json["zoneID"].dictionary{
                    if APPLANGUAGE == "ar"{
                        self.addzone.text = zone["titleAr"]?.string
                    }else{
                        self.addzone.text = zone["titleEN"]?.string
                    }
                }
                if let urlPath = json["logo"].string{
                    if urlPath == "" || urlPath == "default" || urlPath == "Default" {
                        
                        self.logopic.image = UIImage(named:"logo daleel neww-1")
                    }
                    else{
                        let placePhoto = URL(string:"\(urlPath)")!
                        self.logopic.sd_setImage(with: placePhoto)
                    }
                    
                }
                //
                
                //
                self.facebook = json["face"].string!
                print("testtt1\(self.facebook)")
                if self.facebook == "" || self.facebook == "default" || self.facebook == "Default"  {
                    self.faceshow.isEnabled = false
                }
                else{
                    self.faceshow.isEnabled = true
                }
                self.instgram = json["insta"].string!
                print("testtt2\(self.instgram)")
                if self.instgram == "" || self.instgram == "default" || self.instgram == "Default"{
                    self.instgramshow.isEnabled = false
                }
                else{
                    self.instgramshow.isEnabled = true
                }
                self.youtube = json["insta"].string!
                if self.youtube == "" || self.youtube == "default" || self.youtube == "Default"{
                      self.yoytubeshow.isEnabled = true
                }else{
                 
                    self.yoytubeshow.isEnabled = false
                }
                self.website = json["website"].string!
                if self.website != "" || self.website != "default" || self.website != "Default"{
                    self.websiteshow.isEnabled = false
                }else{
                    self.websiteshow.isEnabled = true
                }
                self.whatsapp = json["whats"].string!
                if self.whatsapp == "" || self.whatsapp == "default" || self.whatsapp == "Default"{
                    self.whatsappshow.isEnabled = true
                }else {
                    
                    self.whatsappshow.isEnabled = false
                }
                self.email = json["email"].string!
                if self.email == "" || self.email == "default" || self.email == "Default"{
                    self.emailshow.isEnabled = false
                }else {
                    self.emailshow.isEnabled = true
                    
                }
                self.phNo = json["mobile"].string!
                if json["img1"].string! == "" || json["img1"].string! == "default" || json["img1"].string! == "Default"  {
                   self.images[0] = ""
                }else{
                    
                     self.images[0] = json["img1"].string!
                }
                if let img2 = json["img2"].string {
                    if  img2 == "" || img2 == "default" || img2 == "Default"{
                       self.images[1] = ""
                    }else{
                        
                         self.images[1] = img2
                    }
                }
                if let img3 = json["img3"].string {
                    if img3 == "" || img3 == "default" || img3 == "Default"{
                        self.images[2] = ""
                    }else{
                        
                        self.images[2] = json["img3"].string!
                    }
                }
                if let img4 = json["img4"].string {
                    if img4 == "" || img4 == "default" || img4 == "Default"{
                         self.images[3] = ""
                    }else{
                      
                         self.images[3] = json["img4"].string!
                    }
                }
                if let img5 = json["img5"].string {
                    if img5 == "" || img5 == "default" || img5 == "Default"{
                        self.images[4] = ""
                    }else{
                        
                        self.images[4] = json["img5"].string!
                    }
                }
                if let img6 = json["img6"].string {
                    if img6 == "" || img6 == "default" || img6 == "Default"{
                         self.images[5] = ""
                    }else{
                       
                        self.images[5] = json["img6"].string!
                    }
                }
                for image in self.images{
                    print(self.images)
                    if image == "" || image == "default" || image == "Default" || image == "defaultImage"{
                        let x = ImageSource(image: #imageLiteral(resourceName: "defaultImage"))
                        self.localSource.append(x)
                        if self.localSource.count == self.images.count{
                            self.updateSlideShow()
                        }
                        
                    }
                    else {
                        
                        do{
                            let url = URL(string: image)
                            let defaultUrl = URL(string: self.str)
                            let data = try Data(contentsOf: url!)
                            let x = ImageSource(image: UIImage(data: data)!)
                            self.localSource.append(x)
                            if self.localSource.count == self.images.count{
                                self.updateSlideShow()
                            }
                        }
                        catch{
                            print(error.localizedDescription)
                        }
                    }
                }
                
                
                let langit = json["lang"].doubleValue
                let latit = json["lat"].doubleValue
                
                UserDefaults.standard.set(langit, forKey: "langitplace")
                UserDefaults.standard.set(latit, forKey: "latitplace")
                if json["title"].stringValue == "" || json["title"].stringValue == "default" || json["title"].stringValue == "Default"{
                   self.name.text = "NoName".localized
                }
                else{
                    
                     self.name.text = json["title"].stringValue
                }
                if json["description"].stringValue == "" || json["description"].stringValue == "default" || json["description"].stringValue == "Default"{
                    self.adddescription.text = "NoDescription".localized
                }
                else{
                    
                    self.adddescription.text = json["description"].stringValue
                }
                self.totalrate = json["totalFav"].intValue
                self.totalfav.text = String(self.totalrate)
                self.rating.rating = json["totalRate"].doubleValue
                
                
            case .failure(let error):
                print(error)
                HUD.hide()
            }
        }

    }
    @IBAction func deleteplace(_ sender: Any) {
        let alertController = UIAlertController(title: "Attention".localized, message: "messegeDelete".localized, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "ok".localized, style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            WebServices.instance.removeuserplace(id: self.placeID, completion: { (status,error ) in
                if status{
                    print(self.placeID)
                    print(status)
                    self.navigationController?.popViewController(animated: true)
                }
                else if error == ""{
                }
            })

        }
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)

    }
    
    @IBAction func faviconbtn(_ sender: Any) {

        if favicon.image(for: .normal) == #imageLiteral(resourceName: "favorite-heart-button (5)"){
            WebServices.instance.addPlaceTofavorite(placeID: placeID, completion: { (status, error) in
                if status{
                self.favicon.setImage(#imageLiteral(resourceName: "favorite-heart-button (4)"), for: .normal)
                print("Fav Done")
                    self.totalrate = self.totalrate + 1
                    self.totalfav.text = String(self.totalrate)

                }else if error == ""{
                    print("error")
                }
            })
        }else if favicon.image(for: .normal) == #imageLiteral(resourceName: "favorite-heart-button (4)"){
            WebServices.instance.RemovePlaceFromfavorite(placeID: placeID, completion: { (status,error ) in
                if status{
                    self.favicon.setImage(#imageLiteral(resourceName: "favorite-heart-button (5)"), for: .normal)
                    print("Not Fav Done")
                    self.totalrate = self.totalrate - 1
                    self.totalfav.text = String(self.totalrate)

                }else if error == ""{
                    print("ERROR")
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        emailwtsapp.isHidden = true
        imageselect.isHidden = true
        WebServices.instance.Checkfavorite { (status) in
            if status == -1{
                print("asdasdadsasd",status)
                self.favicon.setImage(#imageLiteral(resourceName: "favorite-heart-button (5)"), for: .normal)
            }else if status == 1{
                print(status)
                self.favicon.setImage(#imageLiteral(resourceName: "favorite-heart-button (4)"), for: .normal)
            }
        }

//        emailwtsapp.isHidden = true
//        imageselect.isHidden = true
//        self.websiteshow.isHidden = true
//        self.instgramshow.isHidden = true
//        self.whatsappshow.isHidden = true
//        self.yoytubeshow.isHidden = true
//        self.faceshow.isHidden = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slideshow.addGestureRecognizer(gestureRecognizer)
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        
      
    }

    @objc func didTap() {
        if self.cantap == true {
            slideshow.presentFullScreenController(from: self)
        }

    }
    
    func updateSlideShow(){

        self.indicator.hide()
        self.cantap = true
        self.slideshow.setImageInputs(self.localSource )
        
        self.slideshow.layer.cornerRadius = 2
        self.slideshow.layer.shadowColor = UIColor.black.cgColor
        self.slideshow.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)  //Here you control x and y
        self.slideshow.layer.shadowOpacity = 0.5
        self.slideshow.layer.shadowRadius = 5.0 //Here your control your blur
        self.slideshow.layer.masksToBounds =  false
        self.slideshow.backgroundColor = UIColor(hexString: "23C9B8")
        self.slideshow.slideshowInterval = 5.0
        self.slideshow.pageControlPosition = PageControlPosition.underScrollView
        self.slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        self.slideshow.pageControl.pageIndicatorTintColor = UIColor.black
        self.slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        self.slideshow.activityIndicator = DefaultActivityIndicator()
        self.slideshow.currentPageChanged = { page in
            print("current page:", page)
        }
    }
}
