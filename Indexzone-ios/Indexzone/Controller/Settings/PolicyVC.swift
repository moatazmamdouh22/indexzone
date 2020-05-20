//
//  PolicyVC.swift
//  Indexzone
//
//  Created by MacBook on 2/21/18.
//  Copyright © 2018 Technosaab. All rights reserved.
//

import UIKit

class PolicyVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APPPOLICY.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if APPLANGUAGE == "ar"{
            cell.textLabel?.text = APPPOLICY[indexPath.row].titleAR
        }else{
            cell.textLabel?.text = APPPOLICY[indexPath.row].titleEN
        }
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    override func viewDidLoad() {
        tableview.reloadData()
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "POLICY".localized
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


