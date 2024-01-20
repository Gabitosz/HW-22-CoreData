//
//  ViewController.swift
//  HW-22-CoreData
//
//  Created by Gabriel Zdravkovici on 25.12.2023.
//

import UIKit

class UsersMainViewController: UIViewController {
    
    var users = [UserItem]()
    
    var presenter: UsersPresenter?
    
    // MARK: Outlets
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 20
        textField.textColor = .blue
        textField.layer.borderColor = AppColor.lightPurple.uiColor.cgColor
        textField.layer.borderWidth = 3
        textField.placeholder = "Enter username"
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.purple.uiColor
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onCreateButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var usersTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        return table
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        setupHierarchy()
        setupLayout()
        hideKeyboardWhenTappedAround()
        setupKeyboardObservers()
        presenter = UsersPresenter(view: self)
        presenter?.presentUsers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.presenter?.presentUsers()
            self.usersTable.reloadData()
        }
    }
    
    // MARK: Setup
    
    private func setupHierarchy() {
        let views = [textField, addButton, usersTable]
        views.forEach { view.addSubview($0) }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            
            usersTable.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            usersTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            usersTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            usersTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    // MARK: Actions
    
    @objc private func onCreateButtonPressed(_ sender: UIButton) {
        
        guard let userName = textField.text, !userName.isEmpty else {
            let alert = UIAlertController(title: "Ooops!", message: "Username cannot be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            self.present(alert, animated: true)
            return
        }
        
        let gender = ""
        presenter?.createUser(name: userName, dateOfBirth: nil, gender: gender)
        presenter?.presentUsers()
        textField.text = ""
        DispatchQueue.main.async {
            self.usersTable.reloadData()
        }
    }
}

extension UsersMainViewController: PresenterView {
    func fetch(usersData: [UserItem]) {
        users = usersData
    }
}


