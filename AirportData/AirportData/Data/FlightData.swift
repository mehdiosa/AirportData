//
//  FlightData.swift
//  AirportData
//
//  Created by Osama Mehdi on 10.08.23.
//

import Foundation

struct Flights {
    var flightInfo: [String: [FlightOverview]]
    var type: FlightDataType
}

struct FlightData: Decodable {
    var data: [FlightOverview]
}

struct FlightOverview: Decodable, Identifiable, Equatable, Hashable {
    static func == (lhs: FlightOverview, rhs: FlightOverview) -> Bool {
        lhs.flight.codeshared?.flightNumber == rhs.flight.codeshared?.flightNumber
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(flight.codeshared?.flightNumber)
    }

    enum CodingKeys: String, CodingKey {
        case departure, arrival, airline, flight

        case flightDate = "flight_date"
        case flightStatus = "flight_status"
    }

    var id = UUID()
    var flightDate: String?
    var flightStatus: FlightStatus
    var departure: FlightInfo
    var arrival: FlightInfo
    var airline: Airline
    var flight: Flight
}

struct FlightInfo: Decodable {
    var airport: String?
    var iata: String?
    var terminal: String?
    var gate: String?
    var scheduled: String?
    var estimated: String?
}

struct Airline: Decodable {
    var name: String?
}

struct Flight: Decodable {
    var iata: String?
    let codeshared: Codeshared?
}

struct Codeshared: Decodable {
    let airlineName: String
    let airlineIata: String
    let airlineIcao: String
    let flightNumber: String
    let flightIata: String
    let flightIcao: String

    enum CodingKeys: String, CodingKey {
        case airlineName = "airline_name"
        case airlineIata = "airline_iata"
        case airlineIcao = "airline_icao"
        case flightNumber = "flight_number"
        case flightIata = "flight_iata"
        case flightIcao = "flight_icao"
    }
}

enum FlightStatus: String, Codable {
    case scheduled
    case active
    case landed
    case cancelled
    case incident
    case diverted
    case noStatus
}

enum FlightDataType: String, CaseIterable {
    case arrival
    case departure
}
