//
//  ProfileVC.swift
//  Indexzone
//
//  Created by MacBook on 1/21/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import SDWebImage
class ProfileVC: UIViewController {
    
    @IBOutlet weak var testimage: UIButton!
    @IBOutlet weak var viewAdd: UIStackView!
    @IBOutlet weak var viewChange: UIStackView!
    @IBOutlet weak var viewEdit: UIStackView!
    @IBOutlet weak var btnAddImg2: UIButton!
    @IBOutlet weak var btnAddImg: UIButton!
    @IBOutlet weak var btnCangeImg2: UIButton!
    @IBOutlet weak var btnChangeImg: UIButton!
    @IBOutlet weak var btnEditImg2: UIButton!
    @IBOutlet weak var btnEditImg: UIButton!
    @IBOutlet weak var btnAddPlace: UIButton!
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var editmyaccount: UIButton!
    @IBOutlet weak var changepassword: UIButton!
    @IBOutlet weak var addedplaces: UIButton!
    @IBOutlet weak var signout: UIButton!
    
    let userID = UserDefaults.standard.value(forKey: "id") as? String
    var img = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        WebServices.instance.getUserData(userID: userID ?? "") { (imagePath) in
            self.img = imagePath
            print("img",self.img)
        }
        editmyaccount.setTitle("editmyaccount".localized, for: .normal)
        changepassword.setTitle("changepass".localized, for: .normal)
        addedplaces.setTitle("addedplace".localized, for: .normal)
        signout.setTitle("signout".localized, for: .normal)

        // Do any additional setup after loading the view.
       // profileimg.image! = UIImage(data: image as! Data)!
    }
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "id")
        skip = nil 
        
        

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
        self.navigationItem.title = "Profile".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        name.text! = UserDefaults.standard.value(forKey: "fullname") as?  String ?? ""
        email.text! = UserDefaults.standard.value(forKey: "email") as? String ?? ""
            profileimg.image = UIImage(named: "edit_user")

         if  skip != nil{
            self.displaySkipAlert(message: "skipProfile".localized, title: "Attention".localized)
            self.btnAddImg.isEnabled = false
            self.btnAddImg2.isEnabled = false
            self.btnAddPlace.isEnabled = false
            self.btnChangeImg.isEnabled = false
            self.btnChangePassword.isEnabled = false
            self.btnCangeImg2.isEnabled = false
            self.btnEditImg.isEnabled = false
            self.btnEditImg2.isEnabled = false
            self.editmyaccount.isEnabled = false
            email.text = "John@Simth.com"
            name.text = "John Simth"
        }
        else{
            self.btnAddImg.isEnabled = true
            self.btnAddImg2.isEnabled = true
            self.btnAddPlace.isEnabled = true
            self.btnChangeImg.isEnabled = true
            self.btnChangePassword.isEnabled = true
            self.btnCangeImg2.isEnabled = true
            self.btnEditImg.isEnabled = true
            self.btnEditImg2.isEnabled = true
            self.editmyaccount.isEnabled = true
        }
        
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
extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
