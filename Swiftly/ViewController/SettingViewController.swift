//
//  SettingViewController.swift
//  SidemenuSampleApp
//
//  Created by Mayank agarwal  on 20/03/22.
//

import UIKit
import Eureka

class SettingViewController: FormViewController {
    @IBOutlet var sideMenuBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        form +++ Section("Section1")
            <<< TextRow(){ row in
                row.title = "BaseClassName"
                row.placeholder = "Enter baseclass name"
            }
            <<< TextRow(){ row in
                row.title = "AuthorName"
                row.placeholder = "Enter author name"
            }
            <<< TextRow(){ row in
                row.title = "CompanyName"
                row.placeholder = "Enter company name"
            }
               }
    

   
}
