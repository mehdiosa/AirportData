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

    func test_arrivalDataSwipeBetweenTerminals_swipingBetweenTerminalsIsPossibleAndOnlySpecificTerminalDataIsShown() throws {
        let arrivalButton = XCUIApplication().tabBars["Tab Bar"].buttons["Arrivals"]

        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).swipeLeft()
        let terminal1Check = checkTerminalPageData(terminal: "1")
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).swipeLeft()
        let terminal2Check = checkTerminalPageData(terminal: "2")

        let dataResult = terminal1Check && terminal2Check

        XCTAssertTrue(dataResult && arrivalButton.isSelected)
    }

    func test_departureDataSwipeBetweenTerminals_swipingBetweenTerminalsIsPossibleAndOnlySpecificTerminalDataIsShown() throws {
        let departureButton = XCUIApplication().tabBars["Tab Bar"].buttons["Departures"]
        departureButton.tap()

        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).swipeLeft()
        let terminal1Check = checkTerminalPageData(terminal: "1")
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).swipeLeft()
        let terminal2Check = checkTerminalPageData(terminal: "2")

        let dataResult = terminal1Check && terminal2Check

        XCTAssertTrue(dataResult && departureButton.isSelected)
    }

    func test_arrivalDataSwipeBetweenTerminalsBackAndForth_swipingBetweenTerminalsIsPossible() throws {
        // Fourth Element was chosen because it is the first one to be different on every page
        let staticTextsUIElementsBeforeSwipes = XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 4).staticTexts.allElementsBoundByIndex

        let staticTextsStringsBeforeSwipes = createStringArrayFromXCUIElementArray(staticTextsUIElementsBeforeSwipes)

        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).swipeLeft()
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).swipeLeft()

        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).swipeRight()
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).swipeRight()
        
        let staticTextsUIElementsAfterSwipes = XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 4).staticTexts.allElementsBoundByIndex

        let staticTextsStringsAfterSwipes = createStringArrayFromXCUIElementArray(staticTextsUIElementsAfterSwipes)
        
        XCTAssertTrue(compareStaticTextsBeforeAndAfterSwipes(staticTextsStringsBeforeSwipes, staticTextsStringsAfterSwipes))
    }

    func test_departureDataSwipeBetweenTerminalsBackAndForth_swipingBetweenTerminalsIsPossible() throws {
        let departureButton = XCUIApplication().tabBars["Tab Bar"].buttons["Departures"]
        departureButton.tap()

        // Second Element was chosen because it is the first one to be different on every page
        let staticTextsUIElementsBeforeSwipes = XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 2).staticTexts.allElementsBoundByIndex

        let staticTextsStringsBeforeSwipes = createStringArrayFromXCUIElementArray(staticTextsUIElementsBeforeSwipes)

        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).swipeLeft()
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).swipeLeft()

        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).swipeRight()
        XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).swipeRight()

        let staticTextsUIElementsAfterSwipes = XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 2).staticTexts.allElementsBoundByIndex

        let staticTextsStringsAfterSwipes = createStringArrayFromXCUIElementArray(staticTextsUIElementsAfterSwipes)

        XCTAssertTrue(compareStaticTextsBeforeAndAfterSwipes(staticTextsStringsBeforeSwipes, staticTextsStringsAfterSwipes))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    // Creation of a String array is a must because XCUIElements use the data that is available at the screen at exactly that moment -> String array allows to create a "snapshot" of the data before a change on the screen is made. This way, data can be compared even though the information on the screen might have changed in the meantime
    func createStringArrayFromXCUIElementArray(_ uiElementArray: [XCUIElement]) -> [String] {
        var stringTextArray = [String]()

        for i in 0 ... uiElementArray.count - 1 {
            stringTextArray.append(uiElementArray[i].label)
        }

        return stringTextArray
    }

    func compareStaticTextsBeforeAndAfterSwipes(_ textsBeforeSwipes: [String], _ textsAfterSwipes: [String]) -> Bool {
        if textsBeforeSwipes.count == textsAfterSwipes.count {
            for i in 0 ... textsBeforeSwipes.count - 1 {
                let textBeforeSwipes = textsBeforeSwipes[i]
                let textAfterSwipes = textsAfterSwipes[i]

                if textBeforeSwipes != textAfterSwipes {
                    return false
                }
            }
        } else {
            return false
        }

        return true
    }

    func checkTerminalPageData(terminal: String) -> Bool {
        let cells = XCUIApplication().collectionViews.descendants(matching: .cell).allElementsBoundByIndex

        for var i in 0 ... 3 {
            for e in cells {
                if !e.staticTexts["Terminal: \(terminal)"].exists {
                    // Something else than terminal text was found
                    return false
                }
            }
            XCUIApplication().collectionViews.children(matching: .cell).element(boundBy: 0).swipeUp()
            i += 1
        }
        return true
    }
}
