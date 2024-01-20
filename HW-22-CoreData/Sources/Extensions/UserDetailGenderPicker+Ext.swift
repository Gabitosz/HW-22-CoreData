//
//  UserDetailPickerView.swift
//  HW-22-CoreData
//
//  Created by Gabriel Zdravkovici on 20.01.2024.
//

import UIKit

extension UserDetailViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGender = genders[row]
    }
    
    @objc func genderDoneButtonTapped() {
        let selectedIndex = genderPickerView.selectedRow(inComponent: 0)
        gender.text = genders[selectedIndex]
        gender.resignFirstResponder()
        view.endEditing(true)
    }
}
