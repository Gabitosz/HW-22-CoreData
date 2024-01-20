//
//  KeyboardObservers+Ext.swift
//  HW-22-CoreData
//
//  Created by Gabriel Zdravkovici on 20.01.2024.
//

import UIKit

extension UsersMainViewController {

    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func keyboardWillDisappear() {
        usersTable.isUserInteractionEnabled = true
    }
    
    @objc private func keyboardWillAppear() {
        usersTable.isUserInteractionEnabled = false
    }
}
