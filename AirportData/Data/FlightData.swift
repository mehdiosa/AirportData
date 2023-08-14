//
//  FlightData.swift
//  AirportData
//
//  Created by Osama Mehdi on 10.08.23.
//

import Foundation

struct FlightData: Decodable {
    let data: [FlightOverview]
}

struct FlightOverview: Decodable {
    enum CodingKeys: String, CodingKey {
        case departure, arrival, airline, flight

        case flightDate = "flight_date"
        case flightStatus = "flight_status"
    }

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
    var number: String?
}

enum FlightStatus: String, Codable {
    case scheduled
    case active
    case landed
    case cancelled
    case incident
    case diverted
}
