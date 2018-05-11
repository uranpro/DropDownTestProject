//
//  DropDownViewController.swift
//  dropdownSup
//
//  Created by Mikhail Bushuev on 11/05/2018.
//  Copyright © 2018 xtra. All rights reserved.
//

import UIKit
import DropDown

class DropDownViewController: UIViewController {
    
    @IBOutlet weak var dropDownButton: UIButton!
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropDownSetup()
    }
    
    // MARK: Helerps
    
    func dropDownSetup() {
        DropDown.startListeningToKeyboard()
        DropDown.setupDefaultAppearance()
        
        dropDown.anchorView = dropDownButton
        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
    }
    
    // MARK: User interactions
    
    @IBAction func buttonTap(_ sender: Any) {
        dropDown.show()
    }
    
}
