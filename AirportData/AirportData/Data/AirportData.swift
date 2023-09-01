//
//  AirportData.swift
//  AirportData
//
//  Created by Osama Mehdi on 10.08.23.
//

import Foundation

struct AirportData {
    var arrivalFlightData: FlightData
    var departureFlightData: FlightData
    var isFetching: Bool

    init(arrivalFlightData: FlightData = FlightData(data: []), departureFlightData: FlightData = FlightData(data: []), _ isFetching: Bool = true) {
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

                    let filteredflightData = flightData.data.unique()

                    if flightType == .arrival {
                        self.arrivalFlightData = FlightData(data: filteredflightData.sorted(by: { $0.arrival.scheduled! < $1.arrival.scheduled! }))
                    } else {
                        self.departureFlightData = FlightData(data: filteredflightData.sorted(by: { $0.departure.scheduled! < $1.departure.scheduled! }))
                    }
                }
            }
            self.isFetching = false
        } catch {
            print(error)
        }
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
