//
//  AirportDataTests.swift
//  AirportDataTests
//
//  Created by Osama Mehdi on 10.08.23.
//

@testable import AirportData
import XCTest

final class AirportDataTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // TODO: ADD TESTS FOR REAL API CONNECTION
    func test_airportData_readArrivalFlightDataWithMockData_arrivalFlightDataShouldBeGreaterThan0() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        var airportData = AirportData()
        airportData.readData(forName: "MUC")

        XCTAssertTrue(airportData.arrivalFlightData.flightInfo.count > 0)
    }

    func test_airportData_readDepartureFlightDataWithMockData_departureFlightDataShouldBeGreaterThan0() throws {
        var airportData = AirportData()
        airportData.readData(forName: "MUC")
        XCTAssertTrue(airportData.departureFlightData.flightInfo.count > 0)
    }

    func test_airportData_getAllTerminalsForArrivalsWithMockData_arrivalTerminalsShouldBeGreaterThan0() throws {
        var airportData = AirportData()
        airportData.readData(forName: "MUC")

        var terminals = [String]()

        XCTAssertNotEqual(terminals, [])
    }

    func test_airportData_getAllTerminalsForDeparturesWithMockData_departureTerminalsShouldBeGreaterThan0() throws {
        var airportData = AirportData()
        var allFlightsView = AllFlightsInfoView()

        airportData.readData(forName: "MUC")

        var terminals = [String]()

        XCTAssertNotEqual(terminals, [])
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
