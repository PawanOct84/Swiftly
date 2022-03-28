//
//  Prefs.swift
//  Swiftly
//
//  Created by pawan kumar on 27/03/22.
//

import UIKit


extension UserDefaults {

    public enum Keys {
        static let baseClassName = "base_class_name"
        static let autherName = "auther_name"
        static let companyName = "company_name"
    }

    var baseClassName: String {
        set {
            set(newValue, forKey: Keys.baseClassName)
            synchronize()
        }
        get {
            return string(forKey: Keys.baseClassName) ?? "BaseClass"
        }
    }
    
    var autherName: String {
        set {
            set(newValue, forKey: Keys.autherName)
            synchronize()
        }
        get {
            return string(forKey: Keys.autherName) ?? "Auther Name"
        }
    }
    
    var companyName: String {
        set {
            set(newValue, forKey: Keys.companyName)
            synchronize()
        }
        get {
            return string(forKey: Keys.companyName) ?? "Default Company Name"
        }
    }
}
