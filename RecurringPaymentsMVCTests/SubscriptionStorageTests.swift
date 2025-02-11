
import XCTest
@testable import Recurring_Payments__MVC_

final class SubscriptionStorageTests: XCTestCase {

    var storage: SubscriptionStorage!
    
    override func setUp() {
        super.setUp()
        storage = SubscriptionStorage()
    }
    
    override func tearDown() {
        storage.clear() // очищаем после каждого теста
        super.tearDown()
    }
    
    func testSaveAndLoadSubscriptions() {
        let subscription = Subscription(
            id: UUID(),
            name: "Apple Music",
            price: 54.99,
            renewalDate: Date(),
            cycle: .monthly,
            paymentMethod: "Visa"
        )
        
        storage.save([subscription])
        let loadedSubscriptions = storage.load()
        
        XCTAssertEqual(loadedSubscriptions.count, 1)
        XCTAssertEqual(loadedSubscriptions.first?.name, "Apple Music")
        XCTAssertEqual(loadedSubscriptions.first?.price, 54.99)
    }

}
