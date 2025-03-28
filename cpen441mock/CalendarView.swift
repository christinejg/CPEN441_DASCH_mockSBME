//
//  CalendarView.swift
//  cpen441mock
//
//  Created by Christine Jiang on 2025-03-28.
//


import SwiftUI

struct CalendarView: View {
    @Binding var selectedMonth: Date
    @Binding var startDate: Date
    @Binding var showCalendar: Bool
    
    private let calendar = Calendar.current
    private let daysOfWeek = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]

    var body: some View {
        VStack {
            // Header with Month and Arrows
            HStack {
                Button(action: {
                    changeMonth(by: -1)
                }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text(monthYearString(from: selectedMonth))
                    .font(.headline)
                Spacer()
                Button(action: {
                    changeMonth(by: 1)
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)
            
            // Days of the week
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .bold()
                }
            }
            .padding(.vertical, 4)

            // Dates Grid
            let daysInMonth = generateDaysInMonth(for: selectedMonth)
            let firstDayOffset = firstDayOffset(for: selectedMonth)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(0..<firstDayOffset, id: \.self) { _ in
                    Text("") // Empty slots before first day
                        .frame(height: 30)
                }
                ForEach(daysInMonth, id: \.self) { day in
                    Button(action: {
                        selectDate(day: day)
                    }) {
                        Text("\(day)")
                            .frame(maxWidth: .infinity, minHeight: 30)
                            .background(isSelected(day: day) ? Color.blue.opacity(0.3) : Color.clear)
                            .cornerRadius(5)
                    }
                }
            }

            // Today Button
            Button(action: {
                goToToday()
            }) {
                Text("Today")
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }

    // MARK: - Calendar Helpers
    func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

    func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: selectedMonth) {
            selectedMonth = newMonth
        }
    }

    func generateDaysInMonth(for date: Date) -> [Int] {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return Array(range)
    }

    func firstDayOffset(for date: Date) -> Int {
        let components = calendar.dateComponents([.year, .month], from: date)
        let firstDay = calendar.date(from: components)!
        let weekday = calendar.component(.weekday, from: firstDay) - 1
        return weekday
    }

    func selectDate(day: Int) {
        if let newDate = calendar.date(bySetting: .day, value: day, of: selectedMonth) {
            startDate = newDate
            showCalendar = false
        }
    }

    func goToToday() {
        selectedMonth = Date()
        startDate = Date()
        showCalendar = false
    }

    func isSelected(day: Int) -> Bool {
        guard let newDate = calendar.date(bySetting: .day, value: day, of: selectedMonth) else { return false }
        return calendar.isDate(newDate, inSameDayAs: startDate)
    }
}
