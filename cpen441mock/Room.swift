//
//  Room.swift
//  cpen441mock
//
//  Created by Christine Jiang on 2025-03-26.
//

import Foundation


struct Room: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var bookings: [Booking]
    var capacity: Int
    var hasProjector: Bool
    var hasWhiteboard: Bool

    // Optional: you can add a default room for fallback use
    static let defaultRoom = Room(
        name: "Default Room",
        bookings: [],
        capacity: 0,
        hasProjector: false,
        hasWhiteboard: false
    )
}
