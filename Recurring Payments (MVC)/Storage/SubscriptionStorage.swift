
import Foundation

class SubscriptionStorage {
    private let storageKey = "subscription"
    
    func save(_ subscriptions: [Subscription]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(subscriptions)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Ошибка при кодировании подписок \(error)")
        }
    }

    
    
    func load() -> [Subscription] {
        let decoder = JSONDecoder()
        
        if let savedData = UserDefaults.standard.data(forKey: storageKey),
           let subscriptions = try? decoder.decode([Subscription].self, from: savedData) {
            return subscriptions
        }
        return [] // если ничего нет -> пустой массив
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
}
