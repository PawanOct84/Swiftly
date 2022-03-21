//
//  ReportsViewController.swift
//  ModelGenerator
//
//  Created by pawan kumar on 19/03/22.
//

import UIKit
import Toaster

class ReportsViewController: UIViewController {

    public var reports:String!
    @IBOutlet public var txtReportView:UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        txtReportView.text = reports
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Copy Clipboard", style: .plain, target: self, action: #selector(pasteboardButtonClick))

        let mySlider = UISlider(frame:CGRect(x: 10, y: self.view.frame.height - 115, width: self.view.frame.width - 40, height: 20))
          mySlider.minimumValue = 10
          mySlider.maximumValue = 30
          mySlider.isContinuous = true
          mySlider.tintColor = UIColor.lightGray
          mySlider.value = 20
          mySlider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
          txtReportView.font = UIFont.systemFont(ofSize: CGFloat(mySlider.value))
          self.view.addSubview(mySlider)
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!){
        self.txtReportView.font = UIFont.systemFont(ofSize: CGFloat(sender.value))
        print("Slider step value \(Int(sender.value))")
    }
      
    
    @IBAction func doneButtonClick() {
        self.navigationController?.popToRootViewController(animated: true)
    }
 
    @objc func pasteboardButtonClick() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = reports
        Toast(text: "Copy Clipboard").show()
    }
}
