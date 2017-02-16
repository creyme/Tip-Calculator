//
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by CRISTINA MACARAIG on 2/14/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit



class SettingsViewController: UIViewController, UINavigationControllerDelegate {
    
    
    // OUTLETS
    @IBOutlet var option1Label: UILabel!
    @IBOutlet var option1TextField: UITextField!
    @IBOutlet var option2Label: UILabel!
    @IBOutlet var option2TextField: UITextField!
    @IBOutlet var option3Label: UILabel!
    @IBOutlet var option3TextField: UITextField!
    

    // VARIABLES
    var TipOption1 = Double()
    var TipOption2 = Double()
    var TipOption3 = Double()
    
    var defaultSettingsisOn = true
    
    
    // DEFAULT APP BEHAVIOR
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // SET BG GRADIENT
        let background = CAGradientLayer().creymeColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)
    }

        
    override func viewWillAppear(_ animated: Bool) {
    
        if defaultSettingsisOn == false {
            usersettingsRun()
        } else {
            defaultsettingsRun()
        }
    }
        
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    

    @IBAction func saveUserSettings(_ sender: Any) {
        
        // hide keyboard
        self.view.endEditing(true)

        let option1User = Int(option1TextField.text!) ?? 18
        let option2User = Int(option2TextField.text!) ?? 20
        let option3User = Int(option3TextField.text!) ?? 25
        
        UserDefaults.standard.set(option1User, forKey: "option1")
        UserDefaults.standard.set(option2User, forKey: "option2")
        UserDefaults.standard.set(option3User, forKey: "option3")
        
        let savedOption1 = UserDefaults.standard.object(forKey: "option1")
        let savedOption2 = UserDefaults.standard.object(forKey: "option2")
        let savedOption3 = UserDefaults.standard.object(forKey: "option3")
        
        if option1User == savedOption1 as? Int {
            if option2User == savedOption2 as? Int && option3User == savedOption3 as? Int {
                defaultSettingsisOn = false
            } else {
                print("error saving custom settings")
            }
            
        } else {
            print("error saving custom settings")
        }

        
        // dismiss Settings viewcontroller
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    

    @IBAction func cancelUserSettings(_ sender: Any) {
        
        // hide keyboard
        self.view.endEditing(true)
        
        // dismiss Settings viewcontroller
        self.dismiss(animated: true, completion: nil)
 
    }
    
    
    @IBAction func restoreDefaultSettings(_ sender: Any) {
        
        let option1Default = 18
        let option2Default = 20
        let option3Default = 25

        UserDefaults.standard.set(18, forKey: "option1")
        UserDefaults.standard.set(20, forKey: "option2")
        UserDefaults.standard.set(25, forKey: "option3")
        
        let restoredOption1 = UserDefaults.standard.object(forKey: "option1")
        let restoredOption2 = UserDefaults.standard.object(forKey: "option2")
        let restoredOption3 = UserDefaults.standard.object(forKey: "option3")
        
        if option1Default == restoredOption1 as? Int {
            if option2Default == restoredOption2 as? Int && option3Default == restoredOption3 as? Int {
                defaultSettingsisOn = true
            } else {
                print("error restoring to default settings")
            }

        } else {
            print("error restoring to default settings")
        }
        
        
      
        // dismiss Settings viewcontroller
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func defaultsettingsRun() {
        
        let restoredOption1 = UserDefaults.standard.object(forKey: "option1")
        let restoredOption2 = UserDefaults.standard.object(forKey: "option2")
        let restoredOption3 = UserDefaults.standard.object(forKey: "option3")
        
        if let TipOption1Default = restoredOption1 as? Int {
            option1Label.text = String("Option 1 = \(TipOption1Default)%*")
            option1TextField.placeholder = String(TipOption1Default)
            TipOption1 = Double(TipOption1Default)
            print (TipOption1)
        }

        if let TipOption2Default = restoredOption2 as? Int {
            option2Label.text = String("Option 2 = \(TipOption2Default)%")
            option2TextField.placeholder = String(TipOption2Default)
            TipOption2 = Double(TipOption2Default)
            print (TipOption2)
        }
        
        if let TipOption3Default = restoredOption3 as? Int {
            option3Label.text = String("Option 3 = \(TipOption3Default)%")
            option3TextField.placeholder = String(TipOption3Default)
            TipOption3 = Double(TipOption3Default)
            print (TipOption3)
        }
        
    }
    
    func usersettingsRun() {
        
        let userOption1 = UserDefaults.standard.object(forKey: "option1")
        let userOption2 = UserDefaults.standard.object(forKey: "option2")
        let userOption3 = UserDefaults.standard.object(forKey: "option3")
        
        if let TipOption1User = userOption1 as? Int {
            option1Label.text = String("Option 1 = \(TipOption1User)%*")
            option1TextField.placeholder = String(TipOption1User)
            TipOption1 = Double(TipOption1User)
            print (TipOption1)
        }
        
        if let TipOption2User = userOption2 as? Int {
            option2Label.text = String("Option 2 = \(TipOption2User)%")
            option2TextField.placeholder = String(TipOption2User)
            TipOption2 = Double(TipOption2User)
            print (TipOption2)
        }
        
        if let TipOption3User = userOption3 as? Int {
            option3Label.text = String("Option 3 = \(TipOption3User)%")
            option3TextField.placeholder = String(TipOption3User)
            TipOption3 = Double(TipOption3User)
            print (TipOption3)
        }

        
        
    }
    
    
    
    
    

}
