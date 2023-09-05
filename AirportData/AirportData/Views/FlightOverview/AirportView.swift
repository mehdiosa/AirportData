//
//  AirportView.swift
//  AirportData
//
//  Created by Osama Mehdi on 01.09.23.
//

import SwiftUI

struct AirportView: View {
    @State var airportData: AirportData
    @State var activeTab: String = "Arrivals"

    var body: some View {
        VStack {
            if airportData.isFetching {
                ProgressView("Loading flight data...").background(Color(UIColor.systemBackground))
            } else {
                TabView(selection: $activeTab) {
                    NavigationStack {
                        AllFlightsInfoView(airportData: airportData, flightType: .arrival)
                            .toolbar { reloadToolbarItem() }
                            .toolbarBackground(.hidden, for: .navigationBar)
                            .navigationTitle(Text(activeTab))
                            .navigationBarTitleDisplayMode(.inline)
                    }.tabItem { Label(
                        "Arrivals", systemImage: "airplane.arrival")
                    }.tag("Arrivals")

                    NavigationStack {
                        AllFlightsInfoView(airportData: airportData, flightType: .departure)
                            .toolbar { reloadToolbarItem() }
                            .toolbarBackground(.hidden, for: .navigationBar)
                            .navigationTitle(Text(activeTab))
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    .tabItem { Label(
                        "Departures", systemImage: "airplane.departure")
                    }.tag("Departures")
                }
            }
        }.task { await reloadData() }
    }

    @ToolbarContentBuilder
    func reloadToolbarItem() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                Task {
                    await reloadData()
                }
            } label: {
                Label("reload", systemImage: "arrow.clockwise")
            }
        }
    }

    private func reloadData() async {
        airportData.isFetching = true
        // TODO: CHANGE TO BE DYNAMIC (FOR MOCK SELECT FROM JFK, LAX and MUC; FOR API SELECT FROM ANY AIRPORT)
        airportData.readData(forName: "MUC")
        airportData.isFetching = false
    }
}

struct AirportView_Previews: PreviewProvider {
    static var previews: some View {
        AirportView(airportData: AirportData())
    }
}
