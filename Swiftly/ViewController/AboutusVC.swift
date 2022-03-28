//
//  AboutusVC.swift
//  SidemenuSampleApp
//
//  Created by Mayank agarwal  on 20/03/22.
//

import UIKit
import WebKit

class AboutusVC: UIViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        */

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        //let url = URL(string: "https://en.wikipedia.org/wiki/India")
        //webview.load(URLRequest(url: url!))
    }
    

   

}
