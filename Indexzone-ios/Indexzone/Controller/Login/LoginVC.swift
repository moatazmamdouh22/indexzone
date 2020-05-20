//
//  LoginVC.swift
//  Indexzone
//
//  Created by MacBook on 1/18/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit
import PKHUD
import IQKeyboardManagerSwift
class LoginVC: UIViewController {
    
    
    @IBOutlet weak var btnSkipLogin: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var logintitle: UIButton!
    @IBOutlet weak var regtitle: UIButton!
    @IBOutlet weak var forgetpassword: UIButton!
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        IQKeyboardManager.shared.enable = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func btnSkipLoginPressed(_ sender: Any) {
         skip = "skip"
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeNC")
        self .present(controller!, animated: true, completion: nil)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        logintitle.setTitle("login".localized, for: .normal)
        regtitle.setTitle("register".localized, for: .normal)
        email.placeholder = "email".localized
        password.placeholder = "password".localized
        forgetpassword.setTitle("forget".localized, for: .normal)
        btnSkipLogin.setTitle("skipLogin".localized, for: .normal)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func login(_ sender: Any) {
        if (self.email.text!.isEmpty) == true {
            AlertHandler().displayMyAlertMessage(message: "Enter email", title: "Wrong", okTitle: "ok", view: self)
        }else if (self.password.text!.isEmpty) == true{
            AlertHandler().displayMyAlertMessage(message: "Enter password", title: "Wrong", okTitle: "ok", view: self)
        }else{
            HUD.show(.progress)
            WebServices.instance.login(email: self.email.text!, password: self.password.text!, completion: { (status, error)  in
                if status {
                    HUD.flash(.success, delay: 2.0)
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeNC")
                    self .present(controller!, animated: true, completion: nil)
                     skip = nil
                    
                }else if error == ""{
                    HUD.hide()
                    AlertHandler().displayMyAlertMessage(message: "Wrong Email Or Password", title: "Wrong", okTitle: "ok", view: self)
                }
            })
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = false
 self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.setNavigationBarHidden(false, animated:true)
        self.navigationController?.navigationBar.tintColor = .white
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
