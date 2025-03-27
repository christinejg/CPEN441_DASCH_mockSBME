//
//  RoomTableView.swift
//  cpen441mock
//
//  Created by Christine Jiang on 2025-03-26.
//

import SwiftUI

struct RoomTableView: View {
    var rooms: [Room]
    var date: Date

    @State private var selectedRoomForInfo: Room? = nil

    var body: some View {
        VStack(spacing: 0) {
            // Date Header
            Text(dateHeader(for: date))
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.gray.opacity(0.1))
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                )

            // Table Rows
            ForEach(rooms) { room in
                HStack(spacing: 0) {
                    // LEFT CELL
                    HStack {
                        Text(room.name).font(.custom("Poppins-Medium", size: 13))
                        Button(action: {
                            selectedRoomForInfo = room
                        }) {
                            Image(systemName: "info.circle")
                        }
                    }
                    .frame(width: 150, alignment: .leading)
                    .padding()
                    
                    // 🔥 COLUMN DIVIDER
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 1)

                    // RIGHT CELL
                    VStack(alignment: .leading, spacing: 4) {
                        NavigationLink(destination: ReservationView(room: room, date: date)) {
                            Text("+ New Reservation")
                                .foregroundColor(.blue).font(.custom("Poppins-Medium", size: 13))
                        }

                        ForEach(bookingsForDate(room: room, date: date)) { booking in
                            Text("\(formattedTime(booking.startTime)) - \(formattedTime(booking.endTime)) \(booking.title)")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                )
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
        .overlay(
            // INFO POPUP
            Group {
                if let room = selectedRoomForInfo {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(room.name)
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                selectedRoomForInfo = nil
                            }) {
                                Text("Close")
                                    .foregroundColor(.red)
                            }
                        }
                        Divider()
                        Text("Description: (none)")
                        Text("Contact: (none)")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 10)
                    .frame(maxWidth: 300)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
            }
        )
    }

    func dateHeader(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, M/d/yy"
        return formatter.string(from: date)
    }
    
    func bookingsForDate(room: Room, date: Date) -> [Booking] {
        return room.bookings.filter {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }
    }

    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
