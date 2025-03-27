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
    var description: String
    var contact: String
    var bookings: [Booking]
    var capacity: Int
    var hasProjector: Bool
    var hasWhiteboard: Bool

    // Optional default room in case it's needed
    static let defaultRoom = Room(
        name: "Default Room",
        description: "Default Description",
        contact: "Default Contact",
        bookings: [],
        capacity: 0,
        hasProjector: false,
        hasWhiteboard: false
    )
}
