//
//  AirportDataTests.swift
//  AirportDataTests
//
//  Created by Osama Mehdi on 10.08.23.
//

@testable import AirportData
import XCTest

final class AirportDataTests: XCTestCase {
    let mockAiportArrivalData: [FlightOverview] = [
        FlightOverview(
            flightStatus: FlightStatus.scheduled,
            departure: FlightInfo(airport: "Taiwan Taoyuan International (Chiang Kai Shek International)", iata: "TPE", terminal: nil, gate: nil, scheduled: "2023-08-15T00:05:00+00:00", estimated: "2023-08-15T00:05:00+00:00"),
            arrival: FlightInfo(airport: "Franz Josef Strauss", iata: "MUC", terminal: nil, gate: nil, scheduled: "2023-08-15T06:49:00+00:00", estimated: "2023-08-15T06:49:00+00:00"),
            airline: Airline(name: "EVA Air"),
            flight: Flight(iata: "BR71", codeshared: nil)),
        FlightOverview(
            flightStatus: FlightStatus.scheduled,
            departure: FlightInfo(airport: "Indira Gandhi International", iata: "DEL", terminal: "3", gate: "10", scheduled: "2023-08-15T01:10:00+00:00", estimated: "2023-08-15T01:10:00+00:00"),
            arrival: FlightInfo(airport: "Franz Josef Strauss", iata: "MUC", terminal: "2", gate: "M15", scheduled: "2023-08-15T05:55:00+00:00", estimated: "2023-08-15T05:55:00+00:00"),
            airline: Airline(name: "Lufthanse"),
            flight: Flight(iata: "LH763", codeshared: Codeshared(airlineName: "lufthansa", airlineIata: "lh", airlineIcao: "dlh", flightNumber: "763", flightIata: "lh763", flightIcao: "dlh763"))),
        FlightOverview(
            flightStatus: FlightStatus.scheduled,
            departure: FlightInfo(airport: "Beijing Capital International", iata: "PEK", terminal: "3", gate: nil, scheduled: "2023-08-15T02:00:00+00:00", estimated: "2023-08-15T02:00:00+00:00"),
            arrival: FlightInfo(airport: "Franz Josef Strauss", iata: "MUC", terminal: "2", gate: "I44", scheduled: "2023-08-15T06:20:00+00:00", estimated: "2023-08-15T06:20:00+00:00"),
            airline: Airline(name: "Air Chine LTD"),
            flight: Flight(iata: "CA961", codeshared: Codeshared(airlineName: "air china ltd", airlineIata: "ca", airlineIcao: "cca", flightNumber: "961", flightIata: "ca961", flightIcao: "cca961"))),
        FlightOverview(
            flightStatus: FlightStatus.scheduled,
            departure: FlightInfo(airport: "Singapore Changi", iata: "SIN", terminal: "3", gate: "B4", scheduled: "2023-08-15T00:30:00+00:00", estimated: "2023-08-15T00:30:00+00:00"),
            arrival: FlightInfo(airport: "Franz Josef Strauss", iata: "MUC", terminal: "2", gate: "H44", scheduled: "2023-08-15T06:55:00+00:00", estimated: "2023-08-15T06:55:00+00:00"),
            airline: Airline(name: "Singapore Airlines"),
            flight: Flight(iata: "SQ328", codeshared: Codeshared(airlineName: "lufthansa", airlineIata: "lh", airlineIcao: "dlh", flightNumber: "791", flightIata: "lh791", flightIcao: "dlh791"))),
        FlightOverview(
            flightStatus: FlightStatus.active,
            departure: FlightInfo(airport: "Barajas", iata: "MAD", terminal: "2", gate: "D66", scheduled: "2023-08-14T15:25:00+00:00", estimated: "2023-08-14T15:25:00+00:00"),
            arrival: FlightInfo(airport: "Franz Josef Strauss", iata: "MUC", terminal: "2", gate: "K27", scheduled: "2023-08-14T17:55:00+00:00", estimated: "2023-08-14T17:55:00+00:00"),
            airline: Airline(name: "Oman Air"),
            flight: Flight(iata: "WY5013",
                           codeshared: Codeshared(airlineName: "lufthansa", airlineIata: "lh", airlineIcao: "dlh", flightNumber: "1803", flightIata: "lh1803", flightIcao: "dlh1803")))
    ]
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

    func test_airportData_checkIfFlightDataIsSortedByTerminal_flightDataShouldBeSortedByTerminal() throws {
        let airportData = AirportData()
        let sortedMockFlightData = airportData.sortFlightsByTerminal(mockAiportArrivalData, type: .arrival)

        XCTAssertNotEqual(sortedMockFlightData, mockAiportArrivalData)
    }

    func test_airportData_checkIfFlightDataIsSortedByScheduledArrivalTime_flightDataShouldBeSortedByArrivalTime() throws {
        let airportData = AirportData()
        let sortedMockFlightData = airportData.sortFlightsByTime(mockAiportArrivalData, type: .arrival)

        XCTAssertEqual(sortedMockFlightData, mockAiportArrivalData.sorted(by: { $0.arrival.scheduled! < $1.arrival.scheduled! }))
    }

    func test_airportData_checkIfFlightDataIsSortedByScheduledDepartureTime_flightDataShouldBeSortedByDepartureTime() throws {
        let airportData = AirportData()
        let sortedMockFlightData = airportData.sortFlightsByTime(mockAiportArrivalData, type: .departure)

        XCTAssertEqual(sortedMockFlightData, mockAiportArrivalData.sorted(by: { $0.departure.scheduled! < $1.departure.scheduled! }))
    }

    func test_airportData_checkIfFlightDataEntryForAllFlightsIsCreated_flightDataForAllFlightsShouldBeCreated() throws {}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
