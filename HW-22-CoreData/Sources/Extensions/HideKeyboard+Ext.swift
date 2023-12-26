//
//  HideKeyboard+Ext.swift
//  HW-22-CoreData
//
//  Created by Gabriel Zdravkovici on 25.12.2023.
//

import UIKit

extension UsersMainViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UsersMainViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
