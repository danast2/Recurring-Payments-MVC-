
import Foundation

struct Subscription: Codable {
    let id: UUID
    let name: String
    let price: Double
    let renewalDate: Date
    let cycle: BillingCycle
    let paymentMethod: String
}

extension Subscription{
     func calculateNextBillingDate() -> Date {
        let calendar = Calendar.current
        switch cycle {
        case .monthly:
            return calendar.date(byAdding: .month, value: 1, to: renewalDate) ?? renewalDate
        case .yearly:
            return calendar.date(byAdding: .year, value: 1, to: renewalDate) ?? renewalDate
        case .weekly:
            return calendar.date(byAdding: .day, value: 7, to: renewalDate) ?? renewalDate
        case .halfOfMonth:
            return calendar.date(byAdding: .day, value: 14, to: renewalDate) ?? renewalDate
        case .halfOfYear:
            return calendar.date(byAdding: .month, value: 6, to: renewalDate) ?? renewalDate
        }
    }
}
