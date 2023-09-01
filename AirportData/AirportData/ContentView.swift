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
                AllFlightsInfoView(airportData: airportData, type: .arrival).tabItem { Label(
                    "Arrivals", systemImage: "airplane.arrival")
                }
                AllFlightsInfoView(airportData: airportData, type: .departure).tabItem { Label(
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
