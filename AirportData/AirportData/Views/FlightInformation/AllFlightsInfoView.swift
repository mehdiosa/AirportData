//
//  AllFlightsInfoView.swift
//  AirportData
//
//  Created by Osama Mehdi on 14.08.23.
//

import SwiftUI

struct AllFlightsInfoView: View {
    var airportData: AirportData
    var flightData: Flights
    var flightType: FlightDataType

    @State var activePage: String = ""

    init(airportData: AirportData = AirportData(), flightType: FlightDataType = .arrival) {
        self.airportData = airportData
        self.flightType = flightType

        if self.flightType == .arrival {
            self.flightData = Flights(flightInfo: airportData.arrivalFlightData.flightInfo, type: .arrival)
        } else {
            self.flightData = Flights(flightInfo: airportData.departureFlightData.flightInfo, type: .departure)
        }
    }

    var body: some View {
        if self.flightData.flightInfo.keys.count <= 0 {
            FlightDataView(airline: "", departureCity: "", flightNumber: "", status: FlightStatus.noStatus, plannedTime: "", expectedTime: "", terminal: "")
        } else {
            TabView(selection: self.$activePage) {
                ForEach(Array(self.flightData.flightInfo.keys).sorted(by: <), id: \.self) { terminal in
                    List {
                        ForEach(self.flightData.flightInfo[terminal]!, id: \.self) { flight in
                            FlightDataView(
                                airline: flight.airline.name ?? "",
                                departureCity: self.flightType == .arrival ? flight.departure.airport ?? "" : flight.arrival.airport ?? "",
                                flightNumber: flight.flight.codeshared == nil ? flight.flight.iata ?? "" : flight.flight.codeshared!.flightIata.uppercased(),
                                status: flight.flightStatus,
                                plannedTime: self.flightType == .arrival ? self.getTime(flight.arrival.scheduled ?? "") : self.getTime(flight.departure.scheduled ?? ""),
                                expectedTime: self.flightType == .arrival ? self.getTime(flight.arrival.estimated ?? "") : self.getTime(flight.departure.estimated ?? ""),
                                terminal: self.flightType == .arrival ? flight.arrival.terminal ?? "" : flight.departure.terminal ?? "")
                        }
                    }
                }
            }
            .tabViewStyle(.page).indexViewStyle(.page(backgroundDisplayMode: .never))
            .listStyle(.plain)
            .toolbar {
                self.createQuickNavButtons(Array(self.flightData.flightInfo.keys).sorted(by: <))
            }
            .toolbarBackground(.hidden, for: .tabBar)
        }
    }

    @ToolbarContentBuilder
    func createQuickNavButtons(_ availableTerminals: [String]) -> some ToolbarContent {
        ToolbarItemGroup(placement: .status) {
            ForEach(availableTerminals, id: \.self) { terminal in
                Button(action: { self.activePage = terminal }) {
                    Label(terminal,
                          systemImage:
                          terminal == "" ? self.activePage == terminal ? "airplane.circle.fill" : "airplane.circle" :
                              self.activePage == terminal ? "\(terminal).circle.fill" : "\(terminal).circle")
                }
            }
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
}

struct AllFlightsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AllFlightsInfoView(airportData:
            AirportData(
                arrivalFlightData: Flights(flightInfo: ["1":
                        [FlightOverview(
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
                                    flightIcao: "dlh1947")))],
                    "2": [FlightOverview(
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
                                flightNumber: "1951",
                                flightIata: "lh1947",
                                flightIcao: "dlh1947")))],

                    "3": [FlightOverview(
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
                            terminal: "3",
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
                                flightNumber: "1951",
                                flightIata: "lh1947",
                                flightIcao: "dlh1947")))]], type: .arrival),
                departureFlightData: Flights(flightInfo: ["1":
                        [FlightOverview(
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
                                    flightIcao: "dlh1947")))],
                    "2": [FlightOverview(
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
                                flightNumber: "1951",
                                flightIata: "lh1947",
                                flightIcao: "dlh1947")))],

                    "3": [FlightOverview(
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
                            terminal: "3",
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
                                flightNumber: "1951",
                                flightIata: "lh1947",
                                flightIcao: "dlh1947")))]], type: .departure)),
            flightType: .arrival)

//
//        AllFlightsInfoView(airportData: AirportData(flightData: FlightData(data: [])), type: "arrival")
    }
}
