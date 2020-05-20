//
//  AddPlacesVC.swift
//  Indexzone
//
//  Created by MacBook on 1/21/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import PKHUD
import GoogleMaps

class AddPlacesVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var addzone: UITextField!
    @IBOutlet weak var adddescription: UITextField!
    @IBOutlet weak var whatsapp: UITextField!
    @IBOutlet weak var facebook: UITextField!
    @IBOutlet weak var instagram: UITextField!
    @IBOutlet weak var twitter: UITextField!
    @IBOutlet weak var website: UITextField!
    @IBOutlet weak var youtube: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var addlogo: UIButton!
    @IBOutlet weak var gallary: UIButton!
    @IBOutlet weak var agreeTitle: UIButton!
    @IBOutlet weak var pic1: UIButton!
    @IBOutlet weak var pic2: UIButton!
    @IBOutlet weak var pic3: UIButton!
    @IBOutlet weak var pic4: UIButton!
    @IBOutlet weak var pic5: UIButton!
    @IBOutlet weak var pic6: UIButton!
    @IBOutlet weak var picturesstack: UIStackView!
    @IBOutlet weak var pictureslogo: UIButton!
    
    @IBOutlet weak var btnLocation: UIButton!
    var logopath = ""
    var imagePicked = 0
    var Image_Links = [String](arrayLiteral: "","","","","","")
   var categoryID :String?
    var zoneID = ""
    var gallaryCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adddescription.delegate = self
        agreeTitle.setTitle("agreeTitle".localized, for: .normal)
        setPickerToField(textField: category, title: "Category".localized)
        setPickerToField(textField: addzone, title: "Zones".localized)
        name.placeholder = "Name".localized
        category.placeholder = "Category".localized
        addzone.placeholder = "Zone".localized
        adddescription.placeholder = "desc".localized
        addlogo.setTitle("logo".localized, for: .normal)
        gallary.setTitle("gallary".localized, for: .normal)
        self.whatsapp.placeholder = "whatsapp".localized
        self.facebook.placeholder = "face".localized
        self.instagram.placeholder = "inst".localized
        self.email.placeholder = "email".localized
        self.website.placeholder = "website".localized
        self.twitter.placeholder = "twitter".localized
        self.youtube.placeholder = "yout".localized
        self.mobileNumber.placeholder = "mobile".localized
        
        if APPLANGUAGE == "ar" {
            name.textAlignment = .right
            addzone.textAlignment = .right
            category.textAlignment = .right
            adddescription.textAlignment = .right
        }
        else {
            name.textAlignment = .left
            addzone.textAlignment = .left
            category.textAlignment = .left
            adddescription.textAlignment = .left
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                self.categoryID = APPCATEGORIES[row].id!
            }
            else{
                self.category.text = APPCATEGORIES[row].titleEN
                self.categoryID = APPCATEGORIES[row].id!
            }
        }
            //
        else{
            if APPLANGUAGE == "ar"{
                self.addzone.text = APPZONES[row].titleAR
                self.zoneID = APPZONES[row].id!
                btnLocation.isEnabled = true
            }
            else{
                self.addzone.text = APPZONES[row].titleEN
                self.zoneID = APPZONES[row].id!
                btnLocation.isEnabled = true
            }
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
                    print("ttt \(messeagePhoto)")
                    HUD.flash(.success, delay: 2.0)
                    self.pictureslogo.setImage(image, for: .normal)
                }
            }
        }else if imagePicked == 2{
            WebServices.instance.uploadImage(image: image) { (path) in
                if let urlPath = path{
                    if self.gallaryCount < 6{
                        self.Image_Links[0] = urlPath
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
    @IBAction func exit(_ sender: Any) {
        if let tabsController = UIApplication.shared.delegate?.window??.rootViewController as? MyTabBarVC {
            tabsController.selectedIndex = 2
        }
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
    @IBAction func addPlace(_ sender: Any) {
        //        if name.text?.isEmpty == true{
        //            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredname".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        //        }
        //        else if category.text?.isEmpty == true{
        //             AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredcategory".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        //        }
        if addzone.text?.isEmpty == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredzone".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }
            //        else if adddescription.text?.isEmpty == true{
            //             AlertHandler().displayMyAlertMessage(message: "Makesureyouentereddescription".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
            //        }
        else if mobileNumber.text?.isEmpty  == true{
            AlertHandler().displayMyAlertMessage(message: "Makesureyouenteredmobile".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }
//        else if email.text?.isEmpty  == true{
//            AlertHandler().displayMyAlertMessage(message: "Makesureyouentereemail".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
//        }
        else{
            if (UserDefaults.standard.value(forKey: "latitplace") != nil) && UserDefaults.standard.value(forKey: "langitplace") != nil{
                
                let latitude = UserDefaults.standard.value(forKey: "latitplace") as! Double
                let longitude = UserDefaults.standard.value(forKey: "langitplace") as! Double
                var defaultName:String?
                var defualtDecription:String?
                var facebookk:String?
                var defaultWebsite:String?
                if name.text?.isEmpty == true{
                    defaultName = "default"
                }
                else{
                    defaultName = name.text
                }
                //
                if adddescription.text?.isEmpty == true{
                    defualtDecription = "default"
                }
                else{
                    defualtDecription = adddescription.text
                }
                //
                if adddescription.text?.isEmpty == true{
                    defualtDecription = "default"
                }
                else{
                    defualtDecription = adddescription.text
                }
                //
                if category.text?.isEmpty == true{
                    categoryID = "5b3352717372561edd35e604"
                }
                if Image_Links[0] == ""{
                    Image_Links[0] = "default"
                }
                if Image_Links[1] == ""{
                    Image_Links[1] = "default"
                }
                if Image_Links[2] == ""{
                    Image_Links[2] = "default"
                }
                if Image_Links[3] == ""{
                    Image_Links[3] = "default"
                }
                if Image_Links[4] == ""{
                    Image_Links[4] = "default"
                }
                if Image_Links[5] == ""{
                    Image_Links[5] = "default"
                }
                if logopath == ""{
                    logopath = "default"
                }
                if facebook.text?.isEmpty == true{
                    facebookk = "default"
                }
                else{
                    facebookk = facebook.text
                }
                //
                if website.text?.isEmpty == true{
                    defaultWebsite = "default"
                }
                else{
                    defaultWebsite = website.text
                }
                //
                var defaultWhatApp :String?
                if whatsapp.text?.isEmpty == true{
                    defaultWhatApp = "default"
                }
                else{
                    defaultWhatApp = whatsapp.text
                }
                //
                var defaultTwitter :String?
                if twitter.text?.isEmpty == true{
                    defaultTwitter = "default"
                }
                else{
                    defaultTwitter = twitter.text
                }
                //
                var defaultYoutube :String?
                if youtube.text?.isEmpty == true{
                    defaultYoutube = "default"
                }
                else{
                    defaultYoutube = youtube.text
                }
                //
                var defaultInsta :String?
                if instagram.text?.isEmpty == true{
                    defaultInsta = "default"
                }
                else{
                    defaultInsta = instagram.text
                }
                //
                //                var defaultEmail :String?
                //                if email.text?.isEmpty == true{
                //                    defaultEmail = "default"
                //                }
                //                else{
                //                    defaultEmail = email.text
                //                }
                //
                WebServices.instance.addPlace(logoPath: logopath, img1: Image_Links[0], img2: Image_Links[1], img3: Image_Links[2], img4: Image_Links[3], img5: Image_Links[4], img6: Image_Links[5], title: defaultName!, desc: defualtDecription!, face: facebookk!, insta: defaultInsta!, whatsapp: defaultWhatApp!,website: defaultWebsite!, twitter: defaultTwitter!, youtube: defaultYoutube!, lang:longitude, lat: latitude, categoryID: categoryID! , zoneID: zoneID, mobile: mobileNumber.text!, email: email.text!, completion: { (status,error) in
                    if status{
                        //
                        let name = UserDefaults.standard.value(forKey: "fullname") ?? ""
                        let done = "DoneBy".localized
                        // self.view.makeToast("\(done) \(name)", duration: 2.0, position: .center)
                        HUD.flash(.labeledSuccess(title: "Success".localized, subtitle: "\(done) \(name)"), delay: 4.0)
                       self.performSegue(withIdentifier: "mySegueeID", sender: nil)
                        self.name.text = ""
                        self.category.text = ""
                        self.addzone.text = ""
                        self.adddescription.text = ""
                        self.whatsapp.text = ""
                        self.facebook.text = ""
                        self.instagram.text = ""
                        self.email.text = ""
                        self.website.text = ""
                        self.twitter.text = ""
                        self.youtube.text = ""
                        self.mobileNumber.text = ""
                        self.picturesstack.isHidden = true
                        self.pictureslogo.setImage(#imageLiteral(resourceName: "Group 725"), for: .normal)
                        self.pic1.setImage(#imageLiteral(resourceName: "defaultImage"), for: .normal)
                        self.pic2.setImage(#imageLiteral(resourceName: "defaultImage"), for: .normal)
                        self.pic3.setImage(#imageLiteral(resourceName: "defaultImage"), for: .normal)
                        self.pic4.setImage(#imageLiteral(resourceName: "defaultImage"), for: .normal)
                        self.pic5.setImage(#imageLiteral(resourceName: "defaultImage"), for: .normal)
                        self.pic6.setImage(#imageLiteral(resourceName: "defaultImage"), for: .normal)
                        UserDefaults.standard.removeObject(forKey: "latitplace")
                        UserDefaults.standard.removeObject(forKey: "langitplace")//
                        
                        
                    }
                    else if error == ""{
                        AlertHandler().displayMyAlertMessage(message: "aaaaaaxx".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
                    }
                })
            }
            else{
                HUD.flash(.labeledError(title: "Wrong".localized, subtitle: "PLZSelectYourplaceLOCATION".localized), delay: 4.0)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if skip == nil{
           view.isUserInteractionEnabled = true
        }
        else{
             self.displaySkipAlert(message: "placeAdding".localized, title: "Attention".localized)
            view.isUserInteractionEnabled = false
        }
        if addzone.text == "" || addzone.text == nil{
            btnLocation.isEnabled = false
        }
        else{
            btnLocation.isEnabled = true
        }
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "23C9B8")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        self.tabBarController?.tabBar.shadow = true
        self.tabBarController?.tabBar.barTintColor = UIColor(hexString: "23C9B8")
        self.tabBarController?.tabBar.tintColor = .white
        self.navigationItem.title = "AddPlace".localized
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
