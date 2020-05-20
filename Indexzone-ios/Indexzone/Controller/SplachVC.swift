//
//  SplachVC.swift
//  Indexzone
//
//  Created by MacBook on 1/22/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

class SplachVC: UIViewController {
    let UserID = UserDefaults.standard.value(forKey: "id")
    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(SplachVC.startup), with: nil, afterDelay: 1)
        WebServices.instance.getCategory()
         WebServices.instance.getZones()
        WebServices.instance.Allplacesmap()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func startup(){
        // check if user first time
        //check if user is login
        // segue to home
        
        if UserID == nil {
            self.performSegue(withIdentifier: "login", sender: nil)
        }else{
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeNC")
            self .present(controller!, animated: true, completion: nil)
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
