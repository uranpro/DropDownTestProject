//
//  ActionSheetPickerViewController.swift
//  dropdown
//
//  Created by Mikhail Bushuev on 11/05/2018.
//  Copyright © 2018 xtra. All rights reserved.
//

import UIKit
import CoreActionSheetPicker

class ActionSheetPickerViewController: UIViewController {
    
    // MARK: User interactions
    
    @IBAction func buttonTap(_ sender: Any) {
        ActionSheetStringPicker.show(withTitle: "Look at my horse"
            , rows: ["My", "Horse", "Is", "Amazing"],
              initialSelection: 0, doneBlock: { (sender, index, object) in
                print("done click at index \(index)")
        }, cancel: { (sender) in
            print("cancel click")
        }, origin: sender)
    }
    
}
