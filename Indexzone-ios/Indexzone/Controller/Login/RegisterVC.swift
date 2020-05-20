//
//  RegisterVC.swift
//  Indexzone
//
//  Created by MacBook on 1/18/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import PKHUD
import IQKeyboardManagerSwift
class RegisterVC: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var txtZone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var agreelabel: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var checkeddata: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var regtitle: UIButton!
    
    var zoneID :String?
    var arrayOfZones:[Zone]?
    var arrayOfGender :[String] = ["Male".localized,"Female".localized]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtGender.delegate = self
        txtZone.delegate = self
        regtitle.setTitle("register".localized, for: .normal)
        txtZone.placeholder = "Zone".localized
        txtGender.placeholder = "Gender".localized
        password.placeholder = "password".localized
        txtEmail.placeholder = "email".localized
        password.placeholder = "password".localized
        mobile.placeholder = "mobile".localized
        name.placeholder = "name".localized
        confirmPassword.placeholder = "confirmpass".localized
        agreelabel.setTitle("Agree".localized, for: .normal)
        mobile.keyboardType = UIKeyboardType.phonePad
        
        countryCode.isUserInteractionEnabled = false
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
        // Do any additional setup after loading the view.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtZone{
            setPickerToField(textField: txtZone, title: "Zones".localized)
        }
        else if textField == txtGender{
            setPickerToField(textField: txtGender, title: "Gender".localized)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardHeight = keyboardSize?.height
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardHeight! / 2
        }else{
            self.view.frame.origin.y = 0
            self.view.frame.origin.y -= keyboardHeight! / 2
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        self.view.frame.origin.y = 0
    }
    
    @IBAction func AcceptTerms(_ sender: Any) {
        if checkeddata.image(for: .normal) == #imageLiteral(resourceName: "checked-data"){
            checkeddata.setImage(#imageLiteral(resourceName: "checked-data-1"), for: .normal)
        }else if checkeddata.image(for: .normal) == #imageLiteral(resourceName: "checked-data-1"){
            checkeddata.setImage(#imageLiteral(resourceName: "checked-data"), for: .normal)
        }
    }
    @IBAction func register(_ sender: Any) {
        if (name.text?.isEmpty)! == true {
            AlertHandler().displayMyAlertMessage(message: "Enter Name", title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }
           // else if (txtGender.text?.isEmpty)! == true{
//            AlertHandler().displayMyAlertMessage(message: "EnterYourGender".localized, title: "Wrong", okTitle: "ok", view: self)
//        }
            //
        else if (txtZone.text?.isEmpty)! == true{
            AlertHandler().displayMyAlertMessage(message: "EnterYourZone".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }
        else if (txtEmail.text?.isEmpty)! == true{
            AlertHandler().displayMyAlertMessage(message: "EnterYourZone".localized, title: "Wrong".localized, okTitle: "ok".localized, view: self)
        }
       else if (password.text?.isEmpty)! == true{
            AlertHandler().displayMyAlertMessage(message: "Enter password", title: "Wrong", okTitle: "ok", view: self)
        }else if password.text! != confirmPassword.text!{
            AlertHandler().displayMyAlertMessage(message: "Password Isn't Match", title: "Wrong", okTitle: "ok", view: self)
        }else if  checkeddata.image(for: .normal) == #imageLiteral(resourceName: "checked-data-1"){
            AlertHandler().displayMyAlertMessage(message: "You have to agree to Terms And Condition To Containe register", title: "Attention", okTitle: "ok", view: self)
        }else if  (password.text?.characters.count)! < 6{
            AlertHandler().displayMyAlertMessage(message: "Your Password is Very poor Enter At Least 6 characters", title: "Attention", okTitle: "ok", view: self)
        }
        else{
            HUD.show(.progress)
            WebServices.instance.register(zoneID: self.zoneID ?? "",gender :txtGender.text! , name: name.text!, email: txtEmail.text! , password: password.text!, completion: { (status , error) in
                
                if status {
                    HUD.flash(.success, delay: 2.0)
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "LoginNC")
                    self.present(controller!, animated: true, completion: nil)
                }else if error == ""{
                    HUD.hide()
                    AlertHandler().displayMyAlertMessage(message: "Email Or Mobile Exists", title: "Wrong", okTitle: "ok", view: self)
                }
            })
        }
    }
  ////
}

extension RegisterVC{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1
        {
            return arrayOfGender.count
        }
        else if  pickerView.tag == 2{
            return APPZONES.count
        }
        else{
            return 0
        }
        
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return arrayOfGender[row]
        }
        else{
            if APPLANGUAGE == "ar"{
                return APPZONES[row].titleAR
            }else{
                return APPZONES[row].titleEN
            }
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            txtGender.text = arrayOfGender[row]
        }
        else{
            if APPLANGUAGE == "ar"{
                self.txtZone.text = APPZONES[row].titleAR
            }
            else{
                self.txtZone.text = APPZONES[row].titleEN
            }
            self.zoneID = APPZONES[row].id!
        }
    }
}
