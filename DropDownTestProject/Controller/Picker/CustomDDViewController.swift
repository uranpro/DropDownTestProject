//
//  CustomDDViewController.swift
//  DropDownTestProject
//
//  Created by Mikhail Bushuev on 11/05/2018.
//  Copyright © 2018 rt. All rights reserved.
//

import UIKit

class CustomDDViewController: UIViewController {
    
    
    @IBOutlet weak var centerDropDown: DropDownButton!
    @IBOutlet weak var bottomDropDown: DropDownButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = ["Drop", "Down", "Button", "Data", "Source"]
        [centerDropDown, bottomDropDown].forEach { (button) in
            button?.data = data
            button?.onSelect = { item, index, sender in
                print("did select item with strin \"\(item)\" at index \(index)")
            }
        }
    }
}
