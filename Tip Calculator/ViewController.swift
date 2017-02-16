//
//  ViewController.swift
//  Tip Calculator
//
//  Created by CRISTINA MACARAIG on 2/13/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    
   // OUTLETS
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var swipeLabel: UILabel!

    @IBOutlet var billperpersonLabel: UILabel!
    
    @IBOutlet var splitbillStepper: UIStepper!
    
    @IBOutlet var tipPercentControl: UISegmentedControl!
    
    @IBOutlet var billTextfield: UITextField!
    @IBOutlet var totalbillTextField: UITextField!
    @IBOutlet var splitbillTextField: UITextField!
    
    @IBOutlet var splitbillView: UIView!
    @IBOutlet var totalbillView: UIView!
    
    
    
    // VARIABLES
    
    var savedTipOption1 = Double()
    var savedTipOption2 = Double()
    var savedTipOption3 = Double()
    
    
    var total = Double()
    var splitbillbyValue = Double()
    var totalbillRoundedUp = Double()
    var RoundedUp = false
    
    

    

//--DEFAULT---------------------------------------------------------------------------------
    
    
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // SET BG GRADIENT
        let background = CAGradientLayer().creymeColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)
        
        // SET APPEARANCE
        tipPercentControl.layer.borderColor = UIColor.white.cgColor
        tipPercentControl.tintColor = UIColor.white
        tipPercentControl.layer.borderWidth = 1.5
        
        splitbillStepper.layer.borderColor = UIColor.white.cgColor
        splitbillStepper.layer.borderWidth = 1.5

        splitbillView.layer.borderColor = UIColor.white.cgColor
        splitbillView.layer.borderWidth = 1.5
        splitbillView.alpha = 0.0
        
        billperpersonLabel.alpha = 0.0
    
        
    }
    
    
    // LOCK-IN KEYBOARD FOR BILLTEXTFIELD
    override func viewWillAppear(_ animated: Bool) {
        
        
        let currentView = Double(self.view.frame.size.height)
        
        
        if currentView <= 568.0 {
            // Hide keyboard on tap
            let hideKeyBoardOnTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
            hideKeyBoardOnTap.numberOfTapsRequired = 1
            self.view.isUserInteractionEnabled = true
            self.view.addGestureRecognizer(hideKeyBoardOnTap)
            
        } else {
            billTextfield.becomeFirstResponder()
        }
        
        
        clearcurrentView()
        
        
        // PERCENTAGE OPTIONS:
        savedTipOption1 = UserDefaults.standard.object(forKey: "option1") as? Double ?? 18.0
            let tipPercent1 = String(format: "%.0f", savedTipOption1)
            tipPercentControl.setTitle(String("\(tipPercent1)%"), forSegmentAt: 0)

        savedTipOption2 = UserDefaults.standard.object(forKey: "option2") as? Double ?? 20.0
            let tipPercent2 = String(format: "%.0f", savedTipOption2)
            tipPercentControl.setTitle(String("\(tipPercent2)%"), forSegmentAt: 1)

        savedTipOption3 = UserDefaults.standard.object(forKey: "option3") as? Double ?? 25.00
            let tipPercent3 = String(format: "%.0f", savedTipOption3)
            tipPercentControl.setTitle(String("\(tipPercent3)%"), forSegmentAt: 2)
        
        tipPercentControl.selectedSegmentIndex = 0
        
        splitbillStepper.value = 1.0
        splitbillbyValue = Double(splitbillStepper.value)
        splitbillTextField.text = String(format: "%.0f", splitbillbyValue)
        
        
        
        
        
    }
    
   
    
    // CALCULATE TIP AND TOTAL BILL
    @IBAction func calculateTip(_ sender: AnyObject) {
    calculatTotalBillwithTip()

    }
    
    
    // ACTIVATE SPLIT BILL
    @IBAction func splitBillby(_ sender: AnyObject) {
        
        splitbillbyValue = Double(splitbillStepper.value)
        splitbillTextField.text = String(format: "%.0f", splitbillbyValue)
        
        splitBill()

    }
    
    

    
    
//--TOTAL BILL FUNCTIONS-----------------------------------------------------------------------------------
    
    // CALCULATE TOTAL BILL FUNCTION
    func calculatTotalBillwithTip() {
        let bill = Double(billTextfield.text!) ?? 0
        
        let tip1 = savedTipOption1 / 100.0
        let tip2 = savedTipOption2 / 100.0
        let tip3 = savedTipOption3 / 100.0
        print("tip array: \(tip1), \(tip2), \(tip3)")
        
        let tipPercentages = [tip1, tip2, tip3]
        let tip = bill * tipPercentages[tipPercentControl.selectedSegmentIndex]
        total = bill + tip
        
        // RoundedUp variables
        let roundedUpValue = ceil(total)
        let roundedUpDifference = roundedUpValue - total
        let totalTipRoundedUp = tip + roundedUpDifference
        totalbillRoundedUp = bill + totalTipRoundedUp
        
        
        // Convert to the right currency
        let tipConverted = NumberFormatter.localizedString(from: NSNumber(value: tip), number: NumberFormatter.Style.currency)
        let tipRoundedUpConverted = NumberFormatter.localizedString(from: NSNumber(value: totalTipRoundedUp), number: NumberFormatter.Style.currency)
        let roundedUpDifferenceConverted = NumberFormatter.localizedString(from: NSNumber(value: roundedUpDifference), number: NumberFormatter.Style.currency)
        
        // Display tip and total bill at the right currency
        if billTextfield.text?.isEmpty == false {
  
            
            // SWIPE RIGHT GESTURE
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(gesture:)))
            swipeRight.direction = UISwipeGestureRecognizerDirection.right
            self.view.addGestureRecognizer(swipeRight)
            
            // SWIPE LEFT GESTURE
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(gesture:)))
            swipeLeft.direction = UISwipeGestureRecognizerDirection.left
            self.view.addGestureRecognizer(swipeLeft)
            
            
            if RoundedUp == true {
                tipLabel.text = String("+ \(tipRoundedUpConverted) (added \(roundedUpDifferenceConverted))")
                totalbillTextField.text = String(NumberFormatter.localizedString(from: NSNumber(value: totalbillRoundedUp), number: NumberFormatter.Style.currency))
                swipeLabel.text = "SWIPE LEFT TO DISABLE ROUND OFF DOLLAR"
                UIView.animate(withDuration: 0.8, animations: {
                    self.totalbillView.backgroundColor = UIColor.black
                })
            } else {
                tipLabel.text = String("+ \(tipConverted)")
                totalbillTextField.text = String(NumberFormatter.localizedString(from: NSNumber(value: total), number: NumberFormatter.Style.currency))
                swipeLabel.text = "SWIPE RIGHT TO ROUND OFF DOLLAR"
                UIView.animate(withDuration: 0.8, animations: {
                    self.totalbillView.backgroundColor = UIColor.white
                })
            }
            
            
        // Hide all fields when bill textfield is empty
        } else {
            clearcurrentView()
            
        }
    }
    
    

    
    
//--SPLIT BILL FUNCTIONS-----------------------------------------------------------------------------------
    
    // SPLIT THE BILL FUNCTION
        func splitBill() {
        
            // Calculate the splitted bill
            let splittedbill = total / splitbillbyValue
            let spilttedbillRoundedUp = totalbillRoundedUp / splitbillbyValue
        
            // Convert splittedbill at the right currency
            let splittedbillConverted = NumberFormatter.localizedString(from: NSNumber(value: splittedbill), number: NumberFormatter.Style.currency)
            let splittedbillRoundedUpConverted = NumberFormatter.localizedString(from: NSNumber(value: spilttedbillRoundedUp), number: NumberFormatter.Style.currency)
        
            // Display Splitted Bill
            if splitbillbyValue >= 2 && (billTextfield.text?.isEmpty)! == false {
                
                
                if RoundedUp == true {
                    billperpersonLabel.text = String("\(splittedbillRoundedUpConverted) per person")
                    UIView.animate(withDuration: 0.5, animations: {
                        self.billperpersonLabel.alpha = 0.6
                        self.splitbillView.alpha = 0.6
                    })
                } else {
                    billperpersonLabel.text = String("\(splittedbillConverted) per person")
                    UIView.animate(withDuration: 0.5, animations: {
                        self.billperpersonLabel.alpha = 0.6
                        self.splitbillView.alpha = 0.6
                    })
                }

        
            // Hide Spllitted Bill
            } else {
                UIView.animate(withDuration: 0.8, animations: {
                    self.billperpersonLabel.alpha = 0.0
                    self.splitbillView.alpha = 0.0
                })
            }
        
        }
    
    
    
//--SWIPE FUNCTIONS-----------------------------------------------------------------------------------
    
    // Swipe totalbillView Function
    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.right:
                print ("User swiped right")
                RoundedUp = true
                calculatTotalBillwithTip()
                splitBill()
            case UISwipeGestureRecognizerDirection.left:
                print("User swiped left")
                RoundedUp = false
                calculatTotalBillwithTip()
                splitBill()
            default:
                break
                
            }
            
        }
        
    }
    
   
    // CLEARN VIEW FUNCTION
    func clearcurrentView() {
        // SET STATE
        billTextfield.text = ""
        tipLabel.text = ""
        totalbillTextField.text = ""
        swipeLabel.text = ""
        RoundedUp = false
        
        UIView.animate(withDuration: 0.8, animations: {
            self.totalbillView.backgroundColor = UIColor.white
        })
        UIView.animate(withDuration: 0.8, animations: {
            self.billperpersonLabel.alpha = 0.0
            self.splitbillView.alpha = 0.0
        })

    }
    
    
    
    // CLEAR VIEW WHEN SETTINGS IS TAPPED
    func clearView(_sender: AnyObject) {
        viewDidLoad()
    }
    

    // HIDE KEYBOARD FUNCTION
    func hideKeyBoard() {
        self.view.endEditing(true)
    }

    
    


}

