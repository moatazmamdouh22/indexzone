//
//  SettingsVC.swift
//  Indexzone
//
//  Created by MacBook on 1/21/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var btnCustomerImg2: UIButton!
    @IBOutlet weak var btnCustomerImg: UIButton!
    @IBOutlet weak var changelang: UIButton!
    @IBOutlet weak var policy: UIButton!
    @IBOutlet weak var customer: UIButton!
    
    @IBOutlet weak var rate: UIButton!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var aboutapp: UIButton!
    @IBOutlet weak var terms: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        changelang.setTitle("changelang".localized, for: .normal)
        policy.setTitle("policy".localized, for: .normal)
        rate.setTitle("rate".localized, for: .normal)
        share.setTitle("share".localized, for: .normal)
        terms.setTitle("terms".localized, for: .normal)
        aboutapp.setTitle("aboutapp".localized, for: .normal)
        customer.setTitle("customer".localized, for: .normal)

        // Do any additional setup after loading the view.
    }

    @IBAction func share(_ sender: Any) {
        shareApp(link: "www.google.com", controller: self )
    }
    @IBAction func rateApp(_ sender: Any) {
        let iTunesLink = "itms://itunes.apple.com/us/app/apple-store/id375380948?mt=8"
        if let aLink = URL(string: iTunesLink) {
            UIApplication.shared.open(aLink)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if skip != nil{
            customer.isEnabled = false
            btnCustomerImg.isEnabled = false
            btnCustomerImg2.isEnabled = false
        }
        else{
            customer.isEnabled = true
            btnCustomerImg.isEnabled = true
            btnCustomerImg2.isEnabled = true
        }
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "23C9B8")
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.shadow = true
        self.tabBarController?.tabBar.shadow = true
        self.tabBarController?.tabBar.barTintColor = UIColor(hexString: "23C9B8")
        self.tabBarController?.tabBar.tintColor = .white
        self.navigationItem.title = "Setting".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
    }
   
}
