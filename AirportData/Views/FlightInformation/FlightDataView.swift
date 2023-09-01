//
//  FlightDataView.swift
//  AirportData
//
//  Created by Osama Mehdi on 14.08.23.
//

import SwiftUI

struct FlightDataView: View {
    var airline: String
    var departureCity: String
    var flightNumber: String
    var status: FlightStatus
    var plannedTime: String
    var expectedTime: String
    var terminal: String

    var body: some View {
        VStack {
            Text(self.departureCity.count > 0 ? self.departureCity : "TBA").frame(maxWidth: .infinity, alignment: .leading).bold().padding(.bottom, 10)
            HStack {
                Text("**Terminal:** \(self.terminal.count > 0 ? self.terminal : "TBA")").frame(maxWidth: .infinity, alignment: .leading)
                Text(self.flightNumber.count > 0 ? "**Flight nr.:** \(self.flightNumber)" : "TBA").frame(maxWidth: .infinity, alignment: .center)
            }.padding(.bottom, 10)

            HStack {
                Text(self.plannedTime.count > 0 ? "**Planned:**\n\(self.plannedTime)" : "TBA").frame(maxWidth: .infinity, alignment: .leading)

                Text(self.expectedTime.count > 0 ? "**Scheduled:**\n\(self.expectedTime)" : "TBA").frame(maxWidth: .infinity, alignment: .center)

                Text(self.status != .noStatus ? "**Status:**\n\(Text(self.status.rawValue).foregroundColor(setStatusColor(status: self.status)))" : "TBA").frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }

    // TODO: Change colors for more consistent output
    private func setStatusColor(status: FlightStatus) -> Color {
        switch status {
        case .scheduled: return Color(red: 104/255, green: 152/255, blue: 202/255) // Light blue
        case .active: return Color(red: 53/255, green: 113/255, blue: 170/255) // Blue
        case .landed: return Color.blue // darker blue?
        case .cancelled: return Color.red
        case .incident: return Color(red: 219/255, green: 68/255, blue: 57/255) // Orange or Red
        case .diverted: return Color.orange

        default:
            return Color(UIColor.systemBackground)
        }
    }
}

struct FlightDataView_Previews: PreviewProvider {
    static var previews: some View {
        FlightDataView(airline: "Lufthansa", departureCity: "Berlin", flightNumber: "EN 8309 (E320)", status: FlightStatus.active, plannedTime: "15:00", expectedTime: "15:40", terminal: "2")

//        FlightDataView(airline: "", departureCity: "", flightNumber: "", status: "", plannedArrivalTime: "", expectedArrivalTime: "", terminal: "")
    }
}
