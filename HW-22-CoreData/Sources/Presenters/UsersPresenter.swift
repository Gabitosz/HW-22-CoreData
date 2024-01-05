//
//  UsersPresenter.swift
//  HW-22-CoreData
//
//  Created by Gabriel Zdravkovici on 27.12.2023.
//

import Foundation

class UsersPresenter {
    
    private let usersService = UsersService()
    
    weak var view: PresenterView?
    
    init(view: PresenterView) {
        self.view = view
    }
    
    func presentUsers() {
        self.view?.fetch(usersData: usersService.getAllUsers())
    }
    
    func createUser(name: String, dateOfBirth: Date, gender: String) {
        usersService.create(name: name, dateOfBirth: dateOfBirth, gender: gender)
    }
    
    func updateUser(user: UserItem, newUserName: String, newDateOfBirth: Date, newGender: String) {
        usersService.update(user: user, newUserName: newUserName, newDateOfBirth: newDateOfBirth, newGender: newGender)
    }
    
    func deleteUser(user: UserItem) {
        usersService.delete(user: user)
    }
    
}

protocol PresenterView: AnyObject {
    func fetch(usersData: [UserItem])
}
