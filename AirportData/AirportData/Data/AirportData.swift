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

    init(arrivalFlightData: Flights = Flights(flightInfo: [:], type: .arrival), departureFlightData: Flights = Flights(flightInfo: [:], type: .departure), _ isFetching: Bool = true) {
        self.arrivalFlightData = arrivalFlightData
        self.departureFlightData = departureFlightData
        self.isFetching = isFetching
    }

    mutating func readData(forName name: String) {
        do {
            for flightType in FlightDataType.allCases {
                let resourceName = name + flightType.rawValue.capitalized
                if let bundlePath = Bundle.main.path(forResource: resourceName, ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    let flightData = try JSONDecoder().decode(FlightData.self, from: jsonData)
                    
//                    print(flightData)

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

        if type == .arrival {
            sortedFlights = Dictionary(grouping: flightData, by: { $0.arrival.terminal ?? "" })
        } else if type == .departure {
            sortedFlights = Dictionary(grouping: flightData, by: { $0.departure.terminal ?? "" })
        }

        // Add all flights with empty string key -> This way data of all flights is added where only flights that do not have an terminal assigned yet would have been AND made sure that overview over all flights is ALWAYS the first page as empty string is sorted as first
        sortedFlights[""] = flightData

        return sortedFlights
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
