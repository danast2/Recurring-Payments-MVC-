

import XCTest
@testable import Recurring_Payments__MVC_

final class BillingCycleTests: XCTestCase {

    func testBillingCycleRawValues() {
        XCTAssertEqual(BillingCycle.monthly.rawValue, "monthly")
        XCTAssertEqual(BillingCycle.yearly.rawValue, "yearly")
        XCTAssertEqual(BillingCycle.weekly.rawValue, "weekly")
        XCTAssertEqual(BillingCycle.halfOfMonth.rawValue, "halfOfMonth")
        XCTAssertEqual(BillingCycle.halfOfYear.rawValue, "halfOfYear")
    }

}
