//
//  AddSubscriptionViewController.swift
//  Recurring Payments (MVC)
//
//  Created by Даниил Асташов on 05.02.2025.
//

import UIKit

class AddSubscriptionViewController: UIViewController {

    private let storage = SubscriptionStorage()
    var onAdd: ((Subscription) -> Void)?
    
    //MARK: - UI элементы
    private let nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Название подписки"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let priceField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Цена подписки"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    private let cycleSegmentedControl: UISegmentedControl = {
       let control = UISegmentedControl(items: ["Месяц", "Год", "Неделя", "Полгода", "Полмесяца"])
        control.selectedSegmentIndex = 0
        return control
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIAddViewController()
        setupTapGesture()
    }

    private func setupUIAddViewController(){
        title = "Добавить подписку"
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [nameField, priceField, datePicker, cycleSegmentedControl, saveButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    @objc private func saveTapped() {
        guard let name = nameField.text, !name.isEmpty,
        let priceText = priceField.text, let price = Double(priceText) else {
            showErrorAlert(message: "Введите название и цену подписки")
            return }
        
        let selectedCycle: BillingCycle
        switch cycleSegmentedControl.selectedSegmentIndex {
        case 0:
            selectedCycle = .monthly
        case 1:
            selectedCycle = .yearly
        case 2:
            selectedCycle = .weekly
        case 3:
            selectedCycle = .halfOfYear
        case 4:
            selectedCycle = .halfOfMonth
        default:
            selectedCycle = .monthly
        }
        
        let newSubscription = Subscription(id: UUID(), name: name, price: price, renewalDate: datePicker.date, cycle: selectedCycle, paymentMethod: "Карта")
        
        onAdd?(newSubscription)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - закрытие клавиатуры при тапе
    private  func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}
