//
//  EditPlaceVC.swift
//  Indexzone
//
//  Created by MacBook on 3/20/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import SwiftyJSON
import GoogleMaps

class EditPlaceVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var zonename: UITextField!
    @IBOutlet weak var descrip: UITextField!
    @IBOutlet weak var website: UITextField!
    @IBOutlet weak var twitter: UITextField!
    @IBOutlet weak var youtube: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var whatsapp: UITextField!
    @IBOutlet weak var facebook: UITextField!
    @IBOutlet weak var instgram: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var addlogo: UIButton!
    @IBOutlet weak var gallary: UIButton!
    @IBOutlet weak var agreeTitle: UIButton!
    @IBOutlet weak var exittitle: UIButton!
    @IBOutlet weak var pic1: UIButton!
    @IBOutlet weak var pic2: UIButton!
    @IBOutlet weak var pic3: UIButton!
    @IBOutlet weak var pic4: UIButton!
    @IBOutlet weak var pic5: UIButton!
    @IBOutlet weak var pic6: UIButton!
    @IBOutlet weak var picturesstack: UIStackView!
    @IBOutlet weak var pictureslogo: UIButton!
    
    var logopath = ""
    var imagePicked = 0
    var Image_Links = [String](arrayLiteral: "","","","","","")
    var categoryID = ""
    var zoneID = ""
    var gallaryCount = 0
    var latitude = 0.0
    var longitiude = 0.0
    var placelogo = ""
    var img1 = ""
    var img2 = ""
    var img3 = ""
    var img4 = ""
    var img5 = ""
    var img6 = ""

    var placeID = UserDefaults.standard.value(forKey: "placeID") as! String
    let url = APIKeys().GET_PLACE_ID

    override func viewDidLoad() {
        super.viewDidLoad()
        print("my place ID equal", placeID)
        self.picturesstack.isHidden = true
        if APPLANGUAGE == "ar" {
            name.textAlignment = .right
            zonename.textAlignment = .right
            category.textAlignment = .right
            descrip.textAlignment = .right
        }
        else {
            name.textAlignment = .left
            zonename.textAlignment = .left
            category.textAlignment = .left
            descrip.textAlignment = .left
        }
        

        descrip.delegate = self
        agreeTitle.setTitle("EditTitle".localized, for: .normal)
        exittitle.setTitle("Cancel".localized, for: .normal)

        setPickerToField(textField: category, title: "Categories")
        setPickerToField(textField: zonename, title: "Zones")
        HUD.show(.progress)
        Alamofire.request("\(url)?id=\(placeID)", method: .get , encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                HUD.hide()
                print("\(self.url)?id=\(self.placeID)")
                var json = JSON(value)
                print("All places",json)
                if let category  = json["categoryID"].dictionary{
                    if APPLANGUAGE == "ar"{
                        self.category.text = category["titleAr"]?.string
                    }else{
                        self.category.text = category["titleEN"]?.string
                    }
                    self.categoryID = (category["_id"]?.string)!
                }
                if let zone  = json["zoneID"].dictionary{
                    if APPLANGUAGE == "ar"{
                        self.zonename.text = zone["titleAr"]?.string
                    }else{
                        self.zonename.text = zone["titleEN"]?.string
                    }
                    self.zoneID = (zone["_id"]?.string)!

                }
                if let urlPath = json["logo"].string{
                    self.logopath = urlPath
                    let placePhoto = URL(string:"\(urlPath)")!
                    if let data = try? Data(contentsOf: placePhoto)
                    {
                        let image: UIImage = UIImage(data: data)!
                        self.pictureslogo.setImage(image, for: .normal)
                    }
                }
                if let urlPath = json["img1"].string{
                    self.img1 = urlPath
                    let img1string = URL(string:"\(urlPath)")!
                    if let data = try? Data(contentsOf: img1string)
                    {
                        let image: UIImage = UIImage(data: data)!
                        self.pic1.setImage(image, for: .normal)
                    }
                }
                    if let urlPath = json["img2"].string{
                        self.img2 = urlPath
                        if urlPath != "" {
                        let img1string = URL(string:"\(urlPath)")!
                        if let data = try? Data(contentsOf: img1string)
                        {
                            let image: UIImage = UIImage(data: data)!
                            self.pic2.setImage(image, for: .normal)
                        }
                        }
                }
                    if let urlPath = json["img3"].string{
                        self.img3 = urlPath
                        if urlPath != ""{
                        let img1string = URL(string:"\(urlPath)")!
                        if let data = try? Data(contentsOf: img1string)
                        {
                            let image: UIImage = UIImage(data: data)!
                            self.pic3.setImage(image, for: .normal)
                        }
                        }
                }
                    if let urlPath = json["img4"].string{
                        self.img4 = urlPath
                        if urlPath != ""{
                        let img1string = URL(string:"\(urlPath)")!
                        if let data = try? Data(contentsOf: img1string)
                        {
                            let image: UIImage = UIImage(data: data)!
                            self.pic4.setImage(image, for: .normal)
                        }
                        }
                }
                    if let urlPath = json["img5"].string{
                        self.img5 = urlPath
                        if urlPath != "" {
                        let img1string = URL(string:"\(urlPath)")!
                        if let data = try? Data(contentsOf: img1string)
                        {
                            let image: UIImage = UIImage(data: data)!
                            self.pic5.setImage(image, for: .normal)
                        }
                        }
                }
                    if let urlPath = json["img6"].string{
                        self.img6 = urlPath
                        if urlPath != "" {
                        let img1string = URL(string:"\(urlPath)")!
                        if let data = try? Data(contentsOf: img1string)
                        {
                            let image: UIImage = UIImage(data: data)!
                            self.pic6.setImage(image, for: .normal)
                    }
                        }
                }
                self.placelogo = json["logo"].string!
                
                if let facebook = json["face"].string {
                    if facebook == "" || facebook == "default" || facebook == "Default"{
                        self.facebook.text = ""
                    }else{
                        self.facebook.text = json["face"].string!
                    }
                }
                if let instgram = json["insta"].string {
                    if instgram == "" || instgram == "default" || instgram == "Default"{
                        self.instgram.text = ""
                    }else{
                        self.instgram.text = json["insta"].string!
                    }
                }
                if let website = json["website"].string {
                    if website == "" || website == "default" || website == "Default"{
                        self.website.text = ""
                    }else{
                        self.website.text = json["website"].string!
                    }
                }
                if let wtsapp = json["whats"].string {
                    if wtsapp == "" || wtsapp == "default" || wtsapp == "Default"{
                        self.whatsapp.text = ""
                    }else{
                        self.whatsapp.text = json["whats"].string!
                    }
                }
                if let email = json["email"].string {
                    if email == "" || email == "default" || email == "Default"{
                        self.email.text = ""
                    }else{
                        self.email.text = json["email"].string!
                    }
                }
                if let des = json["description"].string {
                    if des == "" || des == "default" || des == "Default"{
                        self.descrip.text = ""
                    }else{
                        self.descrip.text = json["description"].string!
                    }
                }
                if let twit = json["twit"].string {
                    if twit == "" || twit == "default" || twit == "Default"{
                        self.twitter.text = ""
                    }else{
                        self.twitter.text = json["twit"].string!
                    }
                }

//                self.facebook.text = json["face"].string!
//                self.instgram.text = json["insta"].string!
//                self.website.text = json["website"].string!
//                self.whatsapp.text = json["whats"].string!
//                self.email.text = json["email"].string!
//                self.descrip.text = json["description"].string!
                self.mobile.text = json["mobile"].string!
//                self.twitter.text = json["twit"].string!
                self.longitiude = json["lang"].doubleValue
                self.latitude = json["lat"].doubleValue
                self.name.text = json["title"].stringValue
            case .failure(let error):
                print(error)
                HUD.hide()
            }
        }

    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return APPCATEGORIES.count
        }else{
            return APPZONES.count
            
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            if APPLANGUAGE == "ar"{
                return APPCATEGORIES[row].titleAR
            }else{
                return APPCATEGORIES[row].titleEN
            }
        }else{
            if APPLANGUAGE == "ar"{
                return APPZONES[row].titleAR
            }else{
                return APPZONES[row].titleEN
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            if APPLANGUAGE == "ar"{
                 self.category.text = APPCATEGORIES[row].titleAR
            }else{
                 self.category.text = APPCATEGORIES[row].titleEN
            }
            self.categoryID = APPCATEGORIES[row].id!
        }else{
            if APPLANGUAGE == "ar"{
                self.zonename.text = APPZONES[row].titleAR
            }else{
                self.zonename.text = APPZONES[row].titleEN
            }
            self.zoneID = APPZONES[row].id!
            
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 45
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    @IBAction func addLogo(_ sender: Any) {
        imagePicked = 1
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "Photolibrary".localized, message: "", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if imagePicked == 1{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    let messeagePhoto = URL(string:"\(urlPath)")!
                    self.logopath = path!
                    print("Message",messeagePhoto)
                    HUD.flash(.success, delay: 2.0)
                    self.pictureslogo.setImage(image, for: .normal)
                }
            }
        }else if imagePicked == 2{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[0] = urlPath
                        self.img1 = urlPath
                        //  self.gallaryCount = self.gallaryCount + 1
                    }
                    print(self.Image_Links)
                    HUD.flash(.success, delay: 2.0)
                    self.pic1.setImage(image, for: .normal)
                }
            }
            
            
        }else if imagePicked == 3{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[1] = urlPath
                        self.img2 = urlPath

                        //  self.gallaryCount = self.gallaryCount + 1
                    }
                    print(self.Image_Links)
                    HUD.flash(.success, delay: 2.0)
                    self.pic2.setImage(image, for: .normal)
                }
            }
            
            
        }
        else if imagePicked == 4{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[2] = urlPath
                        self.img3 = urlPath

                        //  self.gallaryCount = self.gallaryCount + 1
                    }
                    print(self.Image_Links)
                    HUD.flash(.success, delay: 2.0)
                    self.pic3.setImage(image, for: .normal)
                }
            }
            
            
        }else if imagePicked == 5{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[3] = urlPath
                        self.img4 = urlPath

                        //  self.gallaryCount = self.gallaryCount + 1
                    }
                    print(self.Image_Links)
                    HUD.flash(.success, delay: 2.0)
                    self.pic4.setImage(image, for: .normal)
                }
            }
        }else if imagePicked == 6{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[4] = urlPath
                        self.img5 = urlPath

                        //  self.gallaryCount = self.gallaryCount + 1
                    }
                    print(self.Image_Links)
                    HUD.flash(.success, delay: 2.0)
                    self.pic5.setImage(image, for: .normal)
                }
            }
        } else if imagePicked == 7{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[5] = urlPath
                        self.img6 = urlPath
                        //  self.gallaryCount = self.gallaryCount + 1
                    }
                    print(self.Image_Links)
                    HUD.flash(.success, delay: 2.0)
                    self.pic6.setImage(image, for: .normal)
                }
            }
            
            
        }
        
        self.dismiss(animated: true, completion: nil)
        HUD.show(.progress)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func pic4gallary(_ sender: Any) {
        imagePicked = 5
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "MaxiumumPicturestoupload".localized, message: "ChooseASource".localized, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .camera
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
        
        
    }
    @IBAction func pic5gallary(_ sender: Any) {
        imagePicked = 6
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "MaxiumumPicturestoupload".localized, message: "ChooseASource".localized, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .camera
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
        
        
    }
    @IBAction func pic6gallary(_ sender: Any) {
        imagePicked = 7
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "MaxiumumPicturestoupload".localized, message: "ChooseASource".localized, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .camera
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
        
        
    }
    
    @IBAction func pic3gallary(_ sender: Any) {
        imagePicked = 4
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "MaxiumumPicturestoupload".localized, message: "ChooseASource".localized, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .camera
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    @IBAction func pic1gallary(_ sender: Any) {
        imagePicked = 2
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "MaxiumumPicturestoupload".localized, message: "ChooseASource".localized, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .camera
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    @IBAction func pic2gallary(_ sender: Any) {
        imagePicked = 3
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        let actionsheet = UIAlertController(title: "MaxiumumPicturestoupload".localized, message: "ChooseASource".localized, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .camera
            self.present(imagepickercontroller, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Photolibrary".localized, style: .default, handler: { (action:UIAlertAction) in
            imagepickercontroller.sourceType = .photoLibrary
            self.present(imagepickercontroller, animated: true, completion: nil)
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
    }
    
    @IBAction func gallary(_ sender: Any) {
        if picturesstack.isHidden == false {
            picturesstack.isHidden = true
        }else if picturesstack.isHidden == true {
            picturesstack.isHidden = false
        }
        
    }
    @IBAction func editbtn(_ sender: Any) {
        if name.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredname".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if category.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredcategory".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if zonename.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredzone".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if descrip.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouentereddescription".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }else if mobile.text?.isEmpty  == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredmobile".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }
        else{
            if self.longitiude != 0 && self.latitude != 0{
                
                let latitude = self.latitude
                let longitude = self.longitiude
                
                WebServices.instance.editPlace(logoPath: logopath, img1: img1, img2: img2, img3: img3, img4: img4, img5: img5, img6: img6, title: name.text!, desc: descrip.text!, face: facebook.text!, insta: instgram.text!, whatsapp: whatsapp.text!,website: website.text!, twitter: twitter.text!, youtube: youtube.text!, lang:longitude, lat: latitude, categoryID: categoryID, zoneID: zoneID, mobile: mobile.text!, email: email.text!, id: placeID, completion: { (status,error) in
                    if status{
                        HUD.flash(.labeledSuccess(title: "Success".localized, subtitle: "YOURPLACEEDITED".localized), delay: 4.0)
                    }
                    else if error == ""{
                        AlertHandler().displayMyAlertMessage(message: "Checkdata".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                    }
                })
            }
            else{
                HUD.flash(.labeledError(title: "Wrong".localized, subtitle: "PLZSelectYourplaceLOCATION".localized), delay: 4.0)
            }
        }
    }
    
    @IBAction func exitbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "23C9B8")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        self.tabBarController?.tabBar.shadow = true
        self.tabBarController?.tabBar.barTintColor = UIColor(hexString: "23C9B8")
        self.tabBarController?.tabBar.tintColor = .white
        self.navigationItem.title = "EditTitle".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

      
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Checking if we are moving to the player screen
    }
}
