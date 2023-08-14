//
//  AirportData.swift
//  AirportData
//
//  Created by Osama Mehdi on 10.08.23.
//

import Foundation

struct AirportData: Decodable {
    var data: [FlightData]
    var isFetching: Bool

    init(data: [FlightData] = [], isFetching: Bool = true) {
        self.data = data
        self.isFetching = isFetching
    }

    func readData(forName name: String) -> FlightData {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"), let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let flight = try JSONDecoder().decode(FlightData.self, from: jsonData)
                return flight
            }
        } catch {
            print(error)
        }

        return FlightData(data: [])
    }
}
