
import Foundation

enum BillingCycle: String, Codable {
    case monthly = "monthly"
    case yearly = "yearly"
    case weekly = "weekly"
    case halfOfMonth = "halfOfMonth"
    case halfOfYear = "halfOfYear"
}
