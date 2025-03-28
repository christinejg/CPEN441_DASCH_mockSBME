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
    @State private var selectedRoomNames: Set<String> = []
    @State private var minCapacity: Int = 0
    @State private var selectedResourceType: String = "-All-"
    @State private var showCalendar = false
    @State private var selectedMonth = Date()
    
    @State private var startDate = Date()
    @State private var duration: Int = 7
    @State private var endDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
    @State private var showFilter = false
    
    @State private var rooms: [Room] = [
        Room(
            name: "2001-Project Room",
            description: "A quiet space for project collaboration.",
            contact: "Contact: project-room@uni.edu",
            bookings: [
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 15, minute: 30),
                    endTime: timeOn(date: Date(), hour: 17, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 9, minute: 0),
                    endTime: timeOn(date: Date(), hour: 10, minute: 30),
                    title: "Research Discussion"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 15, minute: 30),
                    endTime: timeOn(date: Date(), hour: 17, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
            ],
            capacity: 6,
            hasProjector: true,
            hasWhiteboard: true
        ),
        Room(
            name: "2003-Project Room",
            description: "Room with a whiteboard and comfortable seating.",
            contact: "Contact: room-booking@uni.edu",
            bookings: [
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 9, minute: 0),
                    endTime: timeOn(date: Date(), hour: 10, minute: 0),
                    title: "Study Session"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 12, minute: 0),
                    endTime: timeOn(date: Date(), hour: 12, minute: 30),
                    title: "Study Session"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 13, minute: 30),
                    endTime: timeOn(date: Date(), hour: 15, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 17, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 9, minute: 30),
                    endTime: timeOn(date: Date(), hour: 10, minute: 30),
                    title: "Study Session"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Study Session"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 30),
                    endTime: timeOn(date: Date(), hour: 15, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 16, minute: 30),
                    endTime: timeOn(date: Date(), hour: 17, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 9, minute: 0),
                    endTime: timeOn(date: Date(), hour: 11, minute: 0),
                    title: "Study Session"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
            ],
            capacity: 8,
            hasProjector: true,
            hasWhiteboard: true
        ),
        Room(
            name: "2005-Project Room",
            description: "A cozy space with access to a projector and seating for group work.",
            contact: "Contact: 2005-room@uni.edu",
            bookings: [
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 10, minute: 0),
                    endTime: timeOn(date: Date(), hour: 12, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 13, minute: 30),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 16, minute: 30),
                    endTime: timeOn(date: Date(), hour: 17, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 17, minute: 0),
                    endTime: timeOn(date: Date(), hour: 18, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 9, minute: 30),
                    endTime: timeOn(date: Date(), hour: 11, minute: 30),
                    title: "Research Discussion"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 30),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 15, minute: 30),
                    endTime: timeOn(date: Date(), hour: 17, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 12, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 14, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
            ],
            capacity: 4,
            hasProjector: true,
            hasWhiteboard: false
        ),
        Room(
            name: "2007-Project Room",
            description: "Equipped with a large whiteboard and ample seating for brainstorming.",
            contact: "Contact: 2007-room@uni.edu",
            bookings: [
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 10, minute: 30),
                    endTime: timeOn(date: Date(), hour: 12, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 13, minute: 30),
                    endTime: timeOn(date: Date(), hour: 14, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 15, minute: 30),
                    endTime: timeOn(date: Date(), hour: 17, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 9, minute: 0),
                    endTime: timeOn(date: Date(), hour: 10, minute: 30),
                    title: "Research Discussion"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 16, minute: 30),
                    endTime: timeOn(date: Date(), hour: 17, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
            ],
            capacity: 10,
            hasProjector: false,
            hasWhiteboard: true
        ),
        Room(
            name: "2009-Project Room",
            description: "A well-lit space with modern furniture and technology setup.",
            contact: "Contact: 2009-room@uni.edu",
            bookings: [
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 15, minute: 30),
                    endTime: timeOn(date: Date(), hour: 17, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 9, minute: 0),
                    endTime: timeOn(date: Date(), hour: 10, minute: 30),
                    title: "Research Discussion"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 15, minute: 30),
                    endTime: timeOn(date: Date(), hour: 17, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
            ],
            capacity: 12,
            hasProjector: true,
            hasWhiteboard: true
        ),
        Room(
            name: "2011-Project Room",
            description: "A flexible space with movable tables and chairs for collaboration.",
            contact: "Contact: 2011-room@uni.edu",
            bookings: [
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 15, minute: 30),
                    endTime: timeOn(date: Date(), hour: 17, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 9, minute: 0),
                    endTime: timeOn(date: Date(), hour: 10, minute: 30),
                    title: "Research Discussion"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 15, minute: 30),
                    endTime: timeOn(date: Date(), hour: 17, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
            ],
            capacity: 8,
            hasProjector: false,
            hasWhiteboard: true
        ),
        Room(
            name: "2013-Project Room",
            description: "A quiet corner for focused group work with minimal distractions.",
            contact: "Contact: 2013-room@uni.edu",
            bookings: [
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 9, minute: 0),
                    endTime: timeOn(date: Date(), hour: 11, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 15, minute: 30),
                    endTime: timeOn(date: Date(), hour: 17, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Date(),
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 9, minute: 0),
                    endTime: timeOn(date: Date(), hour: 10, minute: 30),
                    title: "Research Discussion"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 15, minute: 30),
                    endTime: timeOn(date: Date(), hour: 17, minute: 30),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 13, minute: 0),
                    endTime: timeOn(date: Date(), hour: 15, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 18, minute: 0),
                    endTime: timeOn(date: Date(), hour: 20, minute: 0),
                    title: "Private Capstone Meeting"
                ),
                Booking(
                    date: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
                    startTime: timeOn(date: Date(), hour: 11, minute: 0),
                    endTime: timeOn(date: Date(), hour: 13, minute: 0),
                    title: "Private Capstone Meeting"
                ),
            ],
            capacity: 5,
            hasProjector: false,
            hasWhiteboard: false
        )
    ]
    
    var body: some View {
        VStack {
            // Navigation Arrows
            HStack {
                Button(action: {
                    changeDuration(by: -7)
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                }

                // Updated to display correctly
                Text(formatDate(startDate) + " - " + formatDate(endDate))
                    .font(.title)
                    .padding()

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

                Button(action: {
                    withAnimation {
                        showCalendar.toggle()
                    }
                }) {
                    Image(systemName: "calendar")
                }

                Button(action: {
                    // Duration Selector Popup
                }) {
                    Text("\(duration) days")
                }
            }
            
            VStack {
                if showCalendar {
                    CalendarView(selectedMonth: $selectedMonth, startDate: $startDate, showCalendar: $showCalendar)
                        .padding(.bottom, 8)
                }

                ScrollView {
                    VStack(alignment: .leading) {
                        if showFilter {
                            FilterMenu(
                                showFilter: $showFilter,
                                selectedRoomNames: $selectedRoomNames,
                                minCapacity: $minCapacity,
                                selectedResourceType: $selectedResourceType
                            )
                        } else {
                            Button("Resource Filter") {
                                showFilter = true
                            }
                            .padding()
                        }

                        ForEach(0..<duration, id: \.self) { offset in
                            let day = Calendar.current.date(byAdding: .day, value: offset, to: startDate)!
                            RoomTableView(rooms: filteredRooms(for: day), date: day)
                        }
                    }
                    .padding(.horizontal)
                }
            }


        }
        .onAppear {
            calculateEndDate()
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"  // ✅ Desired format
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
        let filtered = rooms.filter { room in
            // 1. Check if the room name is selected
            (selectedRoomNames.isEmpty || selectedRoomNames.contains(room.name)) &&
            
            // 2. Check if room meets minimum capacity
            (minCapacity == 0 || room.capacity >= minCapacity) &&
            
            // 3. Check if the room has the selected resource
            (selectedResourceType == "-All-" ||
                (selectedResourceType == "Projector" && room.hasProjector) ||
                (selectedResourceType == "Whiteboard" && room.hasWhiteboard)
            )
        }
        return filtered
    }
    

}
