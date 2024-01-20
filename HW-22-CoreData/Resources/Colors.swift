//
//  Colors.swift
//  HW-22-CoreData
//
//  Created by Gabriel Zdravkovici on 15.01.2024.
//

import UIKit

enum  AppColor {
    
    case lightPurple
    case purple
    
    var uiColor: UIColor {
        switch self {
        case .lightPurple:
            return UIColor(red: 208 / 255, green: 208 / 255, blue: 245 / 255, alpha: 1)
        case .purple:
            return UIColor(red: 108 / 255, green: 117 / 255, blue: 207 / 255, alpha: 1)
        }
    }
}
