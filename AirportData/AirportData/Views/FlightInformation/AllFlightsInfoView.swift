//
//  AllFlightsInfoView.swift
//  AirportData
//
//  Created by Osama Mehdi on 14.08.23.
//

import SwiftUI

struct AllFlightsInfoView: View {
    var airportData: AirportData
    var flightData: FlightData
    var type: FlightDataType

    init(airportData: AirportData = AirportData(), type: FlightDataType = .arrival) {
        self.airportData = airportData
        self.type = .arrival

        if self.type == .arrival {
            self.flightData = airportData.arrivalFlightData
        } else {
            self.flightData = airportData.departureFlightData
        }
    }

    var body: some View {
        if self.flightData.data.count <= 0 {
            FlightDataView(airline: "", departureCity: "", flightNumber: "", status: FlightStatus.noStatus, plannedTime: "", expectedTime: "", terminal: "")
        } else {
//            TabView {
//                ForEach(getTerminals(flightData: flightData), id: \.self) { _ in
            
            List {
                ForEach(self.flightData.data, id: \.self) { flight in
                    FlightDataView(
                        airline: flight.airline.name ?? "",
                        departureCity: self.type == .arrival ? flight.departure.airport ?? "" : flight.arrival.airport ?? "",
                        flightNumber: flight.flight.codeshared == nil ? flight.flight.iata ?? "" : flight.flight.codeshared!.flightIata.uppercased(),
                        status: flight.flightStatus,
                        plannedTime: self.type == .arrival ? self.getTime(flight.arrival.scheduled ?? "") : self.getTime(flight.departure.scheduled ?? ""),
                        expectedTime: self.type == .arrival ? self.getTime(flight.arrival.estimated ?? "") : self.getTime(flight.departure.estimated ?? ""),
                        terminal: self.type == .arrival ? flight.arrival.terminal ?? "" : flight.departure.terminal ?? "")
                }
            }
//                    .tabItem { Label("Arrivals", systemImage: "airplane.arrival") }
//                }
//            }.tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .never))
//                .listStyle(.plain)
        }
    }

    func getTime(_ timestamp: String) -> String {
        let stringToDateFormatter = DateFormatter()
        stringToDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'+'HH:mm"

        let time = timestamp.components(separatedBy: CharacterSet(charactersIn: "T:+"))
        let hour = time[1]
        let minutes = time[2]

        return hour + ":" + minutes
    }

//    func getTerminals(flightData: FlightData) -> [String] {
//        let uniqueTerminals = flightData.data.reduce(into: Set<String>()) { $0.insert($1.arrival.terminal ?? "") }
//
//        return uniqueTerminals.sorted()
//    }
}

struct AllFlightsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AllFlightsInfoView(airportData: AirportData(arrivalFlightData: FlightData(data: [
            FlightOverview(
                flightDate: "2023-08-15",
                flightStatus: FlightStatus.scheduled,
                departure: FlightInfo(
                    airport: "Mikonos",
                    iata: "JMK",
                    terminal: "1",
                    gate: "TestGate",
                    scheduled: "2023-08-14T19:03:00+00:00",
                    estimated: "2023-08-14T19:00:00+00:00"),
                arrival: FlightInfo(
                    airport: "Franz Josef Strauss",
                    iata: "MUC",
                    terminal: "2",
                    gate: "k3",
                    scheduled: "2023-08-14T20:40:00+00:00",
                    estimated: "2023-08-14T20:40:00+00:00"),
                airline: Airline(
                    name: "Eurowings Discover"),
                flight: Flight(
                    iata: "4Y2533",
                    codeshared: Codeshared(
                        airlineName: "lufthansa",
                        airlineIata: "lh",
                        airlineIcao: "dlh",
                        flightNumber: "1947",
                        flightIata: "lh1947",
                        flightIcao: "dlh1947"))),
            FlightOverview(
                flightDate: "2023-08-15",
                flightStatus: FlightStatus.scheduled,
                departure: FlightInfo(
                    airport: "Mikonos",
                    iata: "JMK",
                    terminal: "1",
                    gate: "TestGate",
                    scheduled: "2023-08-14T19:03:00+00:00",
                    estimated: "2023-08-14T19:00:00+00:00"),
                arrival: FlightInfo(
                    airport: "Franz Josef Strauss",
                    iata: "MUC",
                    terminal: "1",
                    gate: "k3",
                    scheduled: "2023-08-14T20:40:00+00:00",
                    estimated: "2023-08-14T20:40:00+00:00"),
                airline: Airline(
                    name: "Eurowings Discover"),
                flight: Flight(
                    iata: "4Y2533",
                    codeshared: Codeshared(
                        airlineName: "lufthansa",
                        airlineIata: "lh",
                        airlineIcao: "dlh",
                        flightNumber: "1947",
                        flightIata: "lh1947",
                        flightIcao: "dlh1947"))),

        ]), departureFlightData: FlightData(data: [
            FlightOverview(
                flightDate: "2023-08-15",
                flightStatus: FlightStatus.scheduled,
                departure: FlightInfo(
                    airport: "Mikonos",
                    iata: "JMK",
                    terminal: "1",
                    gate: "TestGate",
                    scheduled: "2023-08-14T19:03:00+00:00",
                    estimated: "2023-08-14T19:00:00+00:00"),
                arrival: FlightInfo(
                    airport: "Franz Josef Strauss",
                    iata: "MUC",
                    terminal: "2",
                    gate: "k3",
                    scheduled: "2023-08-14T20:40:00+00:00",
                    estimated: "2023-08-14T20:40:00+00:00"),
                airline: Airline(
                    name: "Eurowings Discover"),
                flight: Flight(
                    iata: "4Y2533",
                    codeshared: Codeshared(
                        airlineName: "lufthansa",
                        airlineIata: "lh",
                        airlineIcao: "dlh",
                        flightNumber: "1947",
                        flightIata: "lh1947",
                        flightIcao: "dlh1947"))),
            FlightOverview(
                flightDate: "2023-08-15",
                flightStatus: FlightStatus.scheduled,
                departure: FlightInfo(
                    airport: "Mikonos",
                    iata: "JMK",
                    terminal: "1",
                    gate: "TestGate",
                    scheduled: "2023-08-14T19:03:00+00:00",
                    estimated: "2023-08-14T19:00:00+00:00"),
                arrival: FlightInfo(
                    airport: "Franz Josef Strauss",
                    iata: "MUC",
                    terminal: "2",
                    gate: "k3",
                    scheduled: "2023-08-14T20:40:00+00:00",
                    estimated: "2023-08-14T20:40:00+00:00"),
                airline: Airline(
                    name: "Eurowings Discover"),
                flight: Flight(
                    iata: "4Y2533",
                    codeshared: Codeshared(
                        airlineName: "lufthansa",
                        airlineIata: "lh",
                        airlineIcao: "dlh",
                        flightNumber: "1947",
                        flightIata: "lh1947",
                        flightIcao: "dlh1947"))),

        ])), type: .arrival)
//
//        AllFlightsInfoView(airportData: AirportData(flightData: FlightData(data: [])), type: "arrival")
    }
}
