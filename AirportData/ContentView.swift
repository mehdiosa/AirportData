//
//  ContentView.swift
//  AirportData
//
//  Created by Osama Mehdi on 10.08.23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    var airportData = AirportData()
    var body: some View {
        Text(airportData.readData(forName: "MUCAirportData").data[25].airline.name!)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

