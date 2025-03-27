//
//  ReservationView.swift
//  cpen441mock
//
//  Created by Christine Jiang on 2025-03-26.
//

import SwiftUICore
import SwiftUI


struct ReservationView: View {
    var room: Room
    var date: Date

    @State private var title: String = ""
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    @State private var description: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("New Reservation")
                    .font(.title)
                    .padding(.top)

                Text("Room: \(room.name)")
                Text("Date: \(formattedDate(date))")

                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)

                Text("Description")
                TextEditor(text: $description)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))

                Button("Book") {
                    // Booking logic
                }
                .padding(.top)
            }
            .padding()
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
