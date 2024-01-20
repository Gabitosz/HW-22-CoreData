//
//  InputDateViewPicker+Ext.swift
//  HW-22-CoreData
//
//  Created by Gabriel Zdravkovici on 20.01.2024.
//

import UIKit

extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        
        let screenWidth = UIScreen.main.bounds.width

        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        self.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        
        toolbar.setItems([flexible, barButton], animated: true)
        
        self.inputAccessoryView = toolbar
    }
}
