//
//  TermsVC.swift
//  Swiftly
//
//  Created by Narender Kumar on 22/03/22.
//

import UIKit

class TermsVC: UIViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }
    

}
