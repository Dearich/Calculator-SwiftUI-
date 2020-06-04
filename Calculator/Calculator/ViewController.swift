//
//  ViewController.swift
//  Calculator
//
//  Created by Азизбек on 04.06.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func retunToNormalCaclculator(_ sender: UIButton) {
        if sender.titleLabel?.text == "7" {
            guard let window = UIApplication.shared.windows.first else { return }
            let contentView = ContentView().environmentObject(DisplayTextGlobal())
            window.rootViewController = UIHostingController(rootView: contentView)
            window.makeKeyAndVisible()
            
            
        }
    }

}
