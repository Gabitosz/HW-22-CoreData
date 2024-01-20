//
//  UserDetailDelegate.swift
//  HW-22-CoreData
//
//  Created by Gabriel Zdravkovici on 08.01.2024.
//

import Foundation

protocol UserDetailDelegate: AnyObject {
    func didSelectUser(with data: String)
}
