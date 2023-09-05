//
//  ContentView.swift
//  AirportData
//
//  Created by Osama Mehdi on 10.08.23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @State var airportData = AirportData()
    var body: some View {
        VStack {
            TabView {
                AllFlightsInfoView(airportData: airportData, flightType: .arrival).tabItem { Label(
                    "Arrivals", systemImage: "airplane.arrival")
                }
                AllFlightsInfoView(airportData: airportData, flightType: .departure).tabItem { Label(
                    "Departures", systemImage: "airplane.departure")
                }
            }
        }.task {
            airportData.readData(forName: "MUC")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
