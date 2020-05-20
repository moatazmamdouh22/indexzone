//
//  ForgetpasswordVC.swift
//  Indexzone
//
//  Created by MacBook on 1/18/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

class ForgetpasswordVC: UIViewController {
    
    @IBOutlet weak var exit: UIButton!
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var forgetpass: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        send.setTitle("SendTitle".localized, for: .normal)
        email.placeholder = "email".localized
        exit.setTitle("ExitTitle".localized, for: .normal)
        forgetpass.text = "forgetpass".localized
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func exitbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

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
