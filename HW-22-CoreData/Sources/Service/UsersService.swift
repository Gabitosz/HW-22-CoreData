//
//  UsersService.swift
//  HW-22-CoreData
//
//  Created by Gabriel Zdravkovici on 27.12.2023.
//


import UIKit

class UsersService {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllUsers() -> [UserItem] {
        do {
           return try context.fetch(UserItem.fetchRequest())
            
        } catch {
            print(error)
        }
        return [UserItem()]
    }
    
    func create(name: String, dateOfBirth: Date, gender: String) {
        
        let newUser = UserItem(context: context)
        newUser.name = name
        newUser.dateOfBirth = dateOfBirth
        newUser.gender = gender
        
        do {
            try context.save()
           
        } catch {
            print(error)
        }
    }
    
    func delete(user: UserItem) {
        context.delete(user)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func update(user: UserItem, newUserName: String, newDateOfBirth: Date, newGender: String) {
        user.name = newUserName
        user.dateOfBirth = newDateOfBirth
        user.gender = newGender
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

protocol UsersViewDelegate: NSObjectProtocol {
    func fetchUsers()
}
