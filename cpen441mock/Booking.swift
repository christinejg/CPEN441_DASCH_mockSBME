//
//  Booking.swift
//  cpen441mock
//
//  Created by Christine Jiang on 2025-03-26.
//


import Foundation

struct Booking: Identifiable, Hashable {
    var id = UUID()
    var date: Date // full date of the booking
    var startTime: Date
    var endTime: Date
    var title: String
}
