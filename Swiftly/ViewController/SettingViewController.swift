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
                row.title = "Base Class:"
                row.placeholder = UserDefaults.standard.baseClassName
            }.onChange({ text in
                UserDefaults.standard.baseClassName = text.value!
            })
        
            <<< TextRow(){ row in
                row.title = "Author:"
                row.placeholder = UserDefaults.standard.autherName
            }
            .onChange({ text in
                UserDefaults.standard.autherName = text.value!
            })
        
            <<< TextRow(){ row in
                row.title = "Company:"
                row.placeholder = UserDefaults.standard.companyName
            }.onChange({ text in
                UserDefaults.standard.companyName = text.value!
            })
               
    }
    

   
}
