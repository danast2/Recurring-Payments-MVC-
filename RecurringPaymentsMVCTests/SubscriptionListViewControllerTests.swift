
import XCTest
@testable import Recurring_Payments__MVC_

final class SubscriptionListViewControllerTests: XCTestCase {
    
    var viewController: SubscriptionListViewController!
        
    override func setUp() {
        super.setUp()
        viewController = SubscriptionListViewController()
        viewController.loadViewIfNeeded() // Загружаем View
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testViewControllerHasTableView() {
        let tableView = viewController.view.subviews.first { $0 is UITableView } as? UITableView
            XCTAssertNotNil(tableView, "Должен быть TableView")
    }
    
    func testTableViewHasCorrectDataSource() {
        let tableView = viewController.view.subviews.first { $0 is UITableView } as? UITableView
        XCTAssertNotNil(tableView?.dataSource, "TableView должен иметь DataSource")
    }

}
