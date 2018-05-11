//
//  PickerViewController.swift
//  dropdown
//
//  Created by Mikhail Bushuev on 11/05/2018.
//  Copyright © 2018 xtra. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {
    
    let pickerData = ["Best", "Picker", "Ever"]
    let multiplier = 10
    
}

extension PickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count * multiplier
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row % pickerData.count]
    }
}
