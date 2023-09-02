//
//  AirportData.swift
//  AirportData
//
//  Created by Osama Mehdi on 10.08.23.
//

import Foundation

struct AirportData {
    var arrivalFlightData: Flights = .init(flightInfo: [:], type: .arrival)
    var departureFlightData: Flights = .init(flightInfo: [:], type: .departure)
    var isFetching: Bool

    init(arrivalFlightData: [String: [FlightOverview]] = [String: [FlightOverview]](), departureFlightData: [String: [FlightOverview]] = [String: [FlightOverview]](), _ isFetching: Bool = true) {
        self.arrivalFlightData.flightInfo = arrivalFlightData
        self.departureFlightData.flightInfo = departureFlightData
        self.isFetching = isFetching
    }

    mutating func readData(forName name: String) {
        do {
            for flightType in FlightDataType.allCases {
                let resourceName = name + flightType.rawValue.capitalized
                if let bundlePath = Bundle.main.path(forResource: resourceName, ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    let flightData = try JSONDecoder().decode(FlightData.self, from: jsonData)

                    let filteredflightData = flightData.data.unique()

                    if flightType == .arrival {
                        self.arrivalFlightData.flightInfo = self.sortFlights(filteredflightData, type: .arrival)
                    } else {
                        self.departureFlightData.flightInfo = self.sortFlights(filteredflightData, type: .departure)
                    }
                }
            }
            self.isFetching = false
        } catch {
            print(error)
        }
    }

    func sortFlights(_ flightData: [FlightOverview], type: FlightDataType) -> [String: [FlightOverview]] {
        let flightsSortedByTime = self.sortFlightsByTime(flightData, type: type)
        let flightsSortedByTimeAndTerminal = self.sortFlightsByTerminal(flightsSortedByTime, type: type)
        return flightsSortedByTimeAndTerminal
    }

    func sortFlightsByTime(_ flightData: [FlightOverview], type: FlightDataType) -> [FlightOverview] {
        if type == .arrival {
            return flightData.sorted(by: { $0.arrival.scheduled! < $1.arrival.scheduled! })
        } else if type == .departure {
            return flightData.sorted(by: { $0.departure.scheduled! < $1.departure.scheduled! })
        }
        return []
    }

    func sortFlightsByTerminal(_ flightData: [FlightOverview], type: FlightDataType) -> [String: [FlightOverview]] {
        var sortedFlights: [String: [FlightOverview]] = [:]
        var terminals: [String] = self.getTerminals(flightData, type: type)
    
        // TODO: ADD ALL FLIGHTS TO ANOTHER (ARTIFICIAL) TERMINAL SO THEY CAN BE DISPLAYED AS THE FIRST PAGE
        terminals.append("allFlights")

        for _ in terminals {
            if type == .arrival {
                sortedFlights = Dictionary(grouping: flightData, by: { $0.arrival.terminal ?? "" })
            } else if type == .departure {
                sortedFlights = Dictionary(grouping: flightData, by: { $0.departure.terminal ?? "" })
            }
        }

        return sortedFlights
    }

    func getTerminals(_ flightData: [FlightOverview], type: FlightDataType) -> [String] {
        var uniqueTerminals: Set<String> = []
        if type == .arrival {
            uniqueTerminals = flightData.reduce(into: Set<String>()) { $0.insert($1.arrival.terminal ?? "") }
        } else if type == .departure {
            uniqueTerminals = flightData.reduce(into: Set<String>()) { $0.insert($1.departure.terminal ?? "") }
        }

        return uniqueTerminals.sorted()
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
