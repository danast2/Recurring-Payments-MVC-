

import UIKit

class SubscriptionListViewController: UIViewController {
    private let tableView = UITableView()
    private var subscriptions:  [Subscription] = []
    private let storage = SubscriptionStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isEditing = false
        tableView.allowsSelectionDuringEditing = true
        setupUIListViewController()
        loadSubscriptions()
    }
    
    //MARK: - загрузка подписок
    private func loadSubscriptions() {
        subscriptions = storage.load()
        tableView.reloadData()
    }
    
    //MARK: - сохранение подписок
    private func saveSubscriptions() {
        storage.save(subscriptions)
    }
    
    //MARK: - добавление подписки
    private func addSubscription(_ subscription: Subscription) {
        subscriptions.append(subscription)
        saveSubscriptions()
        
        NotificationManager.shared.scheduleNotification(for: subscription)
    }
    
    //MARK: - удаление подписки по id
    private func removeSubscriptionByID(_ id: UUID) {
        subscriptions.removeAll(where: { $0.id == id })
        saveSubscriptions()
        tableView.reloadData()
        
        NotificationManager.shared.removeNotification(for: id)
    }
    
    //MARK: - настройка UI
    private func setupUIListViewController() {
        title = "Мои Подписки"
        view.backgroundColor = .white
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SubscriptionCell.self, forCellReuseIdentifier: SubscriptionCell.identifier)
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension // ???
        view.addSubview(tableView)
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(<#T##@objc method#>))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Порядок", style: .plain, target: self, action: #selector(toggleEditingMode))
    }
    
    //MARK: - режим редактирования подписок на главной странице
    @objc private func toggleEditingMode() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.leftBarButtonItem?.title = tableView.isEditing ? "Готово" : "Порядок"
    }
    
    //MARK: - открытие экрана добавления подписки
    @objc private func addSubscriptionTapped() {
        //......
    }

}

extension SubscriptionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubscriptionCell.identifier, for: indexPath) as? SubscriptionCell else {
            return UITableViewCell()
        }
        
        let subscription = subscriptions[indexPath.row]
        cell.configure(with: subscription)
        return cell
    }
    
    
}

extension SubscriptionListViewController: UITableViewDelegate {
    
}
