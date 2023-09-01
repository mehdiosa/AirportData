//
//  AirportDataUITests.swift
//  AirportDataUITests
//
//  Created by Osama Mehdi on 10.08.23.
//

import XCTest

final class AirportDataUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TabChangeToDepartures_ChangeFromArrivalsToDeparturesShouldWork() throws {
        let tabBar = XCUIApplication().tabBars["Tab Bar"]
        let departuresButton = tabBar.buttons["Departures"]

        departuresButton.tap()
        XCTAssertTrue(departuresButton.isSelected)
    }

    func test_tabChangeBackToArrivalsFromDepartures_ChangeFromDeparturesToArrivalsShouldWork() throws {
        let tabBar = XCUIApplication().tabBars["Tab Bar"]
        tabBar.buttons["Departures"].tap()

        let arrivalsButton = tabBar.buttons["Arrivals"]

        arrivalsButton.tap()
        XCTAssertTrue(arrivalsButton.isSelected)
    }

    func test_arrivalDataFirstElementExists_ElementShouldExist() throws {
        let firstElementInList = XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(firstElementInList.exists)
    }

    func test_departureDataFirstElementExists_ElementShouldExist() throws {
        let tabBar = XCUIApplication().tabBars["Tab Bar"]
        tabBar.buttons["Departures"].tap()

        let firstElementInList = XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(firstElementInList.exists)
    }

    func test_arrivalDataSwipeBetweenTerminals_swipingBetweenTerminalsIsPossible() throws {
        XCTAssert(false)
    }

    func test_departureDataSwipeBetweenTerminals_swipingBetweenTerminalsIsPossible() throws {
        XCTAssert(false)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
