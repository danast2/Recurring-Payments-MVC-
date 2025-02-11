import XCTest
@testable import Recurring_Payments__MVC_

final class SubscriptionTests: XCTestCase {
    
    func testSubscriptionInitialization() {
        let subscription = Subscription(id: UUID(), name: "Netflix", price: 552.33, renewalDate: Date(), cycle: .monthly, paymentMethod: "visa")
        
        
        XCTAssertNotNil(subscription)
        XCTAssertEqual(subscription.name, "Netflix")
        XCTAssertEqual(subscription.price, 552.33)
        XCTAssertEqual(subscription.cycle, .monthly)
        XCTAssertEqual(subscription.paymentMethod, "visa")
    }
}
