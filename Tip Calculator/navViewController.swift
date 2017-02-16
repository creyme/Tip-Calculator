//
//  navViewController.swift
//  Tip Calculator
//
//  Created by CRISTINA MACARAIG on 2/14/17.
//  Copyright © 2017 creyme. All rights reserved.
//

import UIKit

class navViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize Appearance
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationBar.tintColor = .white
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.isTranslucent = true
        self.navigationBar.barStyle = .blackTranslucent
        self.navigationBar.backgroundColor = UIColor.clear
        
    }


}
