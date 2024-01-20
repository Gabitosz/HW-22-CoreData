//
//  UserDetailViewController.swift
//  HW-22-CoreData
//
//  Created by Gabriel Zdravkovici on 05.01.2024.
//

import UIKit

class UserDetailViewController: UIViewController, PresenterView {
    
    private var isEditingMode = false
    
    var presenter: UsersPresenter?
    
    var selectedUser: UserItem?
    
    let genders = ["Male", "Female", "Other"]
    
    var selectedGender: String?
    
    func fetch(usersData: [UserItem]) {
        
    }
    
    // MARK: Outlets
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.text.rectangle")
        imageView.tintColor = AppColor.purple.uiColor
        return imageView
    }()
    
    private lazy var userNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var nameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = AppColor.purple.uiColor
        return imageView
    }()
    
    lazy var userName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var dateOfBirthStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var dateOfBirthImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = AppColor.purple.uiColor
        return imageView
    }()
    
    lazy var dateOfBirth: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Not specified"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var genderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var genderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "figure.dress.line.vertical.figure")
        imageView.tintColor = AppColor.purple.uiColor
        return imageView
    }()
    
    lazy var gender: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Not specified"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var genderPickerView: UIPickerView = {
        let genderPickerView = UIPickerView()
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderPickerView.translatesAutoresizingMaskIntoConstraints = false
        return genderPickerView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        setupBackButton()
        setupEditButton()
        hideKeyboardWhenTappedAround()
        disableTextFieldsInteraction()
        customizeTextFieldsBorders()
        setUserInfo()
        presenter = UsersPresenter(view: self)
        setPickerViews()
    }
    
    // MARK: Setup
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
    }
    
    private func setupHierarchy() {
        
        let userNameViewElements = [nameImageView, userName]
        userNameViewElements.forEach { userNameStackView.addArrangedSubview($0) }
        userNameStackView.setCustomSpacing(20, after: nameImageView)
        
        let dateOfBirthViewElements = [dateOfBirthImageView, dateOfBirth]
        dateOfBirthViewElements.forEach { dateOfBirthStackView.addArrangedSubview($0) }
        dateOfBirthStackView.setCustomSpacing(20, after: dateOfBirthImageView)
        
        let genderViewElements = [genderImageView, gender]
        genderViewElements.forEach { genderStackView.addArrangedSubview($0) }
        genderStackView.setCustomSpacing(20, after: genderImageView)
        
        let views = [userImageView, userNameStackView, dateOfBirthStackView, genderStackView]
        views.forEach { view.addSubview($0) }
        
    }
    
    private func customizeTextFieldsBorders() {
        userName.addBottomBorder()
        dateOfBirth.addBottomBorder()
        gender.addBottomBorder()
    }
    
    private func disableTextFieldsInteraction() {
        userName.isUserInteractionEnabled = false
        dateOfBirth.isUserInteractionEnabled = false
        gender.isUserInteractionEnabled = false
    }
    
    private func enableTextFieldsInteraction() {
        userName.isUserInteractionEnabled = true
        dateOfBirth.isUserInteractionEnabled = true
        gender.isUserInteractionEnabled = true
    }
    
    private func setUserInfo() {
        userName.text = selectedUser?.name
        dateOfBirth.text = formatToString(date: selectedUser?.dateOfBirth ?? Date())
        gender.text = selectedUser?.gender
    }
    
    private func setPickerViews() {
        dateOfBirth.setInputViewDatePicker(target: self, selector: #selector(setDate))
        setInputViewGenderPicker(target: self, selector: #selector(genderDoneButtonTapped))
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 130),
            userImageView.heightAnchor.constraint(equalToConstant: 100),
            
            userNameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userNameStackView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 50),
            
            dateOfBirthStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateOfBirthStackView.topAnchor.constraint(equalTo: userNameStackView.bottomAnchor, constant: 10),
            
            genderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderStackView.topAnchor.constraint(equalTo: dateOfBirthStackView.bottomAnchor, constant: 10),
            
            nameImageView.widthAnchor.constraint(equalToConstant: 40),
            nameImageView.heightAnchor.constraint(equalToConstant: 40),
            
            dateOfBirthImageView.widthAnchor.constraint(equalToConstant: 40),
            dateOfBirthImageView.heightAnchor.constraint(equalToConstant: 40),
            
            genderImageView.widthAnchor.constraint(equalToConstant: 40),
            genderImageView.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    private func setupBackButton() {
        let customBackButton = UIBarButtonItem(image: UIImage(systemName:  "arrow.left") , style: .plain, target: self, action: #selector(backAction(sender:)))
        customBackButton.tintColor = AppColor.purple.uiColor
        customBackButton.imageInsets = UIEdgeInsets(top: 2, left: -8, bottom: 0, right: 0)
        customBackButton.customView?.transform = CGAffineTransformMakeTranslation(100, 100)
        navigationItem.leftBarButtonItem = customBackButton
    }
    
    @objc private func setDate() {
        if let datePicker = self.dateOfBirth.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/yyyy"
            dateFormatter.dateStyle = .medium
            self.dateOfBirth.text = dateFormatter.string(from: datePicker.date)
        }
        self.dateOfBirth.resignFirstResponder()
    }
    
    private func setupEditButton() {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 70))
        customView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editAction))
        customView.addGestureRecognizer(tapGesture)
        customView.layer.cornerRadius = 10
        customView.layer.borderWidth = 2
        customView.layer.borderColor = AppColor.purple.uiColor.cgColor
        
        let label = UILabel(frame: CGRect(x: 19, y: 10, width: 50, height: 20))
        label.text = "Edit"
        label.textAlignment = .center
        customView.addSubview(label)
        
        if isEditingMode {
            label.text = "Save"
            enableTextFieldsInteraction()
        } else {
            label.text = "Edit"
            disableTextFieldsInteraction()
        }
        
        let customEditButton = UIBarButtonItem(customView: customView)
        navigationItem.rightBarButtonItem = customEditButton
    }
    
    private func setInputViewGenderPicker(target: Any, selector: Selector) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let toolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        
        toolbar.setItems([flexible, barButton], animated: true)
        
        gender.inputAccessoryView = toolbar
        
        gender.inputView = genderPickerView
        
    }
    
    // MARK: Actions
    
    @objc private func backAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editAction(sender: UIGestureRecognizer) {
        
        if isEditingMode {
            
            guard let selectedUser = selectedUser, let newUserName = userName.text, !newUserName.isEmpty, let newDateOfBirth = dateOfBirth.text else {
                return
            }
            
            self.presenter?.updateUser(user: selectedUser, newUserName: newUserName, newDateOfBirth: formatToData(from: newDateOfBirth) ?? Date(), newGender: gender.text ?? "Not Specified")
        }
        
        isEditingMode.toggle()
        setupEditButton()
        
        if let customView = sender.view,
           let _ = navigationItem.rightBarButtonItem {
            UIView.animate(withDuration: 0.1, animations: {
                customView.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    customView.backgroundColor = UIColor.clear
                }
            }
        }
    }
    
    // MARK: Formatters
    
    private func formatToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"
        dateFormatter.dateStyle = .medium
        let formattedData = dateFormatter.string(from: date)
        return formattedData
    }
    
    private func formatToData(from stringData: String) -> Date? {
        
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "dd MMM yyyy"
        if let date = inputDateFormatter.date(from: stringData) {
            
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            
            _ = outputDateFormatter.string(from: date)
            return date
            
        } else {
            print("Ошибка при преобразовании строки в Date.")
        }
        
        return Date()
    }
}

