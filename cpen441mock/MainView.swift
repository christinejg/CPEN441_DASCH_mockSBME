//
//  MainView.swift
//  cpen441mock
//
//  Created by Christine Jiang on 2025-03-26.
//


import SwiftUI

func timeOn(date: Date, hour: Int, minute: Int) -> Date {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone.current
    return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: date) ?? date
}

struct MainView: View {
    @State private var startDate = Date()
    @State private var duration: Int = 7
    @State private var endDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
    @State private var showFilter = false
    
    @State private var rooms: [Room] = [
        Room(
            name: "2001-Project Room",
            bookings: [
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                )
            ],
            capacity: 6,
            hasProjector: true,
            hasWhiteboard: false
        ),
        Room(
            name: "2003-Project Room",
            bookings: [
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 14, minute: 30),
                    endTime: timeOn(date: Date(), hour: 15, minute: 30),
                    title: "Study Group"
                )
            ],
            capacity: 8,
            hasProjector: false,
            hasWhiteboard: true
        )
    ]
    
    var body: some View {
        VStack {
            // Date Range Display
            Text(formatDate(startDate) + " - " + formatDate(endDate))
                .font(.title)
                .padding()

            // Navigation Arrows
            HStack {
                Button(action: {
                    changeDuration(by: -7)
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                }
                Button(action: {
                    changeDuration(by: 7)
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                }
            }
            .padding()

            // Icons for Home, Calendar, and Duration
            HStack {
                Image(systemName: "house.fill")
                Image(systemName: "calendar")
                Button(action: {
                    // Duration Selector Popup
                }) {
                    Text("\(duration) days")
                }
            }
            
            ScrollView {
                    VStack(alignment: .leading) {
                        if showFilter {
                            FilterMenu(showFilter: $showFilter)
                        } else {
                            Button("Resource Filter") {
                                showFilter = true
                            }.padding()
                        }

                        ForEach(0..<duration, id: \.self) { offset in
                            let day = Calendar.current.date(byAdding: .day, value: offset, to: startDate)!
                            RoomTableView(rooms: filteredRooms(for: day), date: day)
                        }
                    }
                    .padding(.horizontal)
                }

        }
        .onAppear {
            calculateEndDate()
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }

    func changeDuration(by days: Int) {
        startDate = Calendar.current.date(byAdding: .day, value: days, to: startDate)!
        calculateEndDate()
    }

    func calculateEndDate() {
        endDate = Calendar.current.date(byAdding: .day, value: duration, to: startDate)!
    }
    
    func filteredRooms(for date: Date) -> [Room] {
        return rooms // <- later, apply actual filtering based on date, room, etc.
    }
    

}
