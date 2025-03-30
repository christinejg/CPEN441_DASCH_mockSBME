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
    @State private var owner: String = "Student"
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    @State private var description: String = ""
    
    // Time options for the dropdown
    var availableTimeSlots: [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        var slots: [String] = []
        var currentTime = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: date)!

        let endTime = Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: date)!
        
        while currentTime <= endTime {
            let timeString = formatter.string(from: currentTime)
            
            // Only add time slots that don't overlap with existing bookings
            if !isTimeSlotBooked(timeString, on: date) {
                slots.append(timeString)
            }
            
            // Increment by 30 minutes
            currentTime = Calendar.current.date(byAdding: .minute, value: 30, to: currentTime)!
        }
        
        return slots
    }
    
    @State private var selectedStartTime = "9:30AM"
    @State private var selectedEndTime = "11:00AM"
    
    var body: some View {
        ScrollView {
            HStack(spacing: 0) {
                // Sidebar with icons, vertically aligned and scrollable
                ScrollView {
                    VStack(spacing: 40) {
                        sidebarIcon(name: "textformat").padding(.bottom, 40)
                        sidebarIcon(name: "person.fill").padding(.bottom, 30)
                        sidebarIcon(name: "clock").padding(.bottom, 150)
                        sidebarIcon(name: "building.2.crop.circle").padding(.bottom, 10)
                        sidebarIcon(name: "pencil")
                    }
                    .frame(width: 40)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.vertical)
                }
                .background(Color.gray.opacity(0.1))

                // Main content with aligned rows, scrollable
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        // Title Field
                        Text("Title").padding(.top, 5)
                        HStack {
                            TextField("Enter title", text: $title)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        Divider().padding()

                        // Owner (Fixed as Student)
                        Text("Owner")
                        HStack {
                            Text(owner)
                        }
                        Divider().padding()

                        // Begin Date & Time
                        Text("Begin")
                        HStack {
                            Text(formatDate(date))
                            Picker("Start Time", selection: $selectedStartTime) {
                                ForEach(availableTimeSlots, id: \.self) { time in
                                    Text(time).tag(time)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }

                        // End Date & Time
                        Text("End")
                        HStack {
                            Text(formatDate(date))
                            Picker("End Time", selection: $selectedEndTime) {
                                ForEach(availableTimeSlots, id: \.self) { time in
                                    Text(time).tag(time)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())

                        }

                        // Duration Calculation
                        HStack {
                            Text("\(calculateDuration()) hours")
                        }

                        Divider()
                            .padding(.vertical, 8)

                        // Room Information
                        Text("Resources")
                        HStack {
                            Text(room.name)
                        }
                        Divider().padding()

                        // Description
                        Text("Description")
                        HStack {
                            TextField("Add a description", text: $description)
                                .padding()
                                .frame(height: 200)
                                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        }

                        // Book Button
                        Button(action: bookRoom) {
                            Text("Book")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    // Helper to create sidebar icons
    func sidebarIcon(name: String) -> some View {
        Image(systemName: name)
            .font(.system(size: 20))
            .padding(8)
            .foregroundColor(.gray)
    }
    
    // Helper to create form rows
    func formRow<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        HStack {
            Text(title + ":")
                .frame(width: 80, alignment: .trailing)
                .font(.custom("Poppins-Medium", size: 13))
            content()
                .frame(maxWidth: .infinity)
        }
    }

    // Format date for display
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }

    // Calculate booking duration in hours
    func calculateDuration() -> String {
        let start = timeToDate(time: selectedStartTime, for: date)
        let end = timeToDate(time: selectedEndTime, for: date)
        
        if end <= start {
            return "Invalid duration"
        }
        
        let duration = end.timeIntervalSince(start) / 3600.0  // Duration in hours
        
        // Check if the duration is a whole number or not
        if duration.truncatingRemainder(dividingBy: 1) == 0 {
            return "\(Int(duration)) hours"  // Whole number
        } else {
            return String(format: "%.1f hours", duration)  // Decimal with 1 decimal place
        }
    }


    // Convert time string to Date object
    func timeToDate(time: String, for date: Date) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mma"
        if let timeDate = formatter.date(from: time) {
            let calendar = Calendar.current
            _ = calendar.dateComponents([.year, .month, .day], from: date)
            let finalDate = calendar.date(bySettingHour: calendar.component(.hour, from: timeDate),
                                          minute: calendar.component(.minute, from: timeDate),
                                          second: 0,
                                          of: date)
            return finalDate ?? date
        }
        return date
    }

    // Booking logic when the button is pressed
    func bookRoom() {
        print("Booking created for \(room.name) on \(formatDate(date)) from \(selectedStartTime) to \(selectedEndTime)")
    }
    func isTimeSlotBooked(_ time: String, on date: Date) -> Bool {
        let slotStartTime = timeToDate(time: time, for: date)
        
        for booking in room.bookings where Calendar.current.isDate(booking.date, inSameDayAs: date) {
            if slotStartTime >= booking.startTime && slotStartTime < booking.endTime {
                return true // Slot is already booked
            }
        }
        
        return false
    }
    

}
