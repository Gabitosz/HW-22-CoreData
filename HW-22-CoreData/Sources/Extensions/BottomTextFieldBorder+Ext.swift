//
//  BottomTextFieldBorder+Ext.swift
//  HW-22-CoreData
//
//  Created by Gabriel Zdravkovici on 15.01.2024.
//

import UIKit

extension UITextField {
    internal func addBottomBorder(height: CGFloat = 1.0, color: UIColor = AppColor.lightPurple.uiColor) {
        
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderView)
        
        NSLayoutConstraint.activate(
            [
                borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
                borderView.heightAnchor.constraint(equalToConstant: height),
                borderView.widthAnchor.constraint(equalToConstant: 270),
            ]
        )
    }
}
