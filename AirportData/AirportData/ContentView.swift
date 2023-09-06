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
            AirportView(airportData: airportData)
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
