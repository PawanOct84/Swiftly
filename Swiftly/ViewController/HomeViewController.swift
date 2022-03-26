//
//  ViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by John Codeos on 2/§/21.
//

import UIKit
import  SwiftyJSON
import Toaster

class HomeViewController: UIViewController {
    @IBOutlet public var txtJsonData:UITextView!
    @IBOutlet public var segmentControl:UISegmentedControl!
    @IBOutlet public var txtBaseClass:UITextField!

    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    let pasteboard = UIPasteboard.general
    var isValidJson = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu Button Tint Color
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Paste Clipboard", style: .plain, target: self, action: #selector(pasteText))

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
          let mySlider = UISlider(frame:CGRect(x: 10, y: self.txtJsonData.frame.height - 0, width: self.txtJsonData.frame.width - 20, height: 20))
          mySlider.minimumValue = 10
          mySlider.maximumValue = 30
          mySlider.isContinuous = true
          mySlider.tintColor = UIColor.lightGray
          mySlider.value = 20
          mySlider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
          txtJsonData.font = UIFont.systemFont(ofSize: CGFloat(mySlider.value))
          self.txtJsonData.addSubview(mySlider)
        pasteboard.string = self.txtJsonData.text
        self.txtJsonData.text = "Please copy json string into clipboard and click on Paste Clipboard."
        
        
        // Add function to handle Value Changed events
        segmentControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
           
        
       }
          
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
        {
            print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        }
        
    
      @objc func sliderValueDidChange(_ sender:UISlider!){
          txtJsonData.font = UIFont.systemFont(ofSize: CGFloat(sender.value))
          print("Slider step value \(Int(sender.value))")
      }
          
    
    @IBAction func pasteText(_ sender: UIButton) {
        if pasteboard.hasStrings{
            txtJsonData.text = pasteboard.string
            validateJson()
        }
    }
    
    func validateJson() {
        isValidJson = false
        let jsonString = txtJsonData.text ?? ""
        if let data = jsonString.data(using: .utf8) {
            if let json = try? JSON(data: data) {
                isValidJson = true
            }
        }
        
        if !isValidJson {
            txtJsonData.borderWidth = 2
            txtJsonData.borderColor = UIColor.red
            Toast(text: "Please paste valid josn from Clipboard.").show()
        }
        else {
            txtJsonData.borderWidth = 2
            txtJsonData.borderColor = UIColor.green
        }

    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "generateUIModel" ||  identifier == "generateCodableModel" {
            if !isValidJson {
                Toast(text: "Please paste valid josn from Clipboard.").show()
                return false
            }
        }
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "generateUIModel",
         let viewController = segue.destination as? EditModelViewController {
          let jsonString = txtJsonData.text ?? ""
          if let data = jsonString.data(using: .utf8) {
              if let json = try? JSON(data: data) {
                  viewController.jsonData = json
                  viewController.baseClassName = self.txtBaseClass.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "BaseClass"
                  
                  if self.segmentControl.selectedSegmentIndex  == 0 {
                      viewController.isRequestModel = true
                  }
                  else {
                      viewController.isRequestModel = true
                  }
                  viewController.isUIModel = true

              }
          }
        }
        else if segue.identifier == "generateCodableModel",
         let viewController = segue.destination as? EditModelViewController {
          let jsonString = txtJsonData.text ?? ""
          if let data = jsonString.data(using: .utf8) {
              if let json = try? JSON(data: data) {
                  viewController.jsonData = json
                  viewController.baseClassName = self.txtBaseClass.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "BaseClass"
                  
                  if self.segmentControl.selectedSegmentIndex  == 0 {
                      viewController.isRequestModel = true
                  }
                  else {
                      viewController.isRequestModel = true
                  }
                  viewController.isUIModel = false
              }
          }
        }
    }
   
}


/// Extend UITextView and implemented UITextViewDelegate to listen for changes
extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !self.text.isEmpty
        }
        
        print("textViewDidChange")
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height

            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = !self.text.isEmpty
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
}
