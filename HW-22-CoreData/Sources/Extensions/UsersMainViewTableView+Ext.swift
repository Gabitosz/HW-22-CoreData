//
//  UsersMainViewTableView+Ext.swift
//  HW-22-CoreData
//
//  Created by Gabriel Zdravkovici on 20.01.2024.
//

import UIKit

extension UsersMainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let userDetailView = UserDetailViewController()
        userDetailView.userName.text = users[indexPath.row].name
        userDetailView.selectedUser = users[indexPath.row]
        self.navigationController?.pushViewController(userDetailView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            
            self.presenter?.deleteUser(user: self.users[indexPath.row])
            self.presenter?.presentUsers()
            
            DispatchQueue.main.async {
                self.usersTable.reloadData()
            }
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
}

extension UsersMainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}
