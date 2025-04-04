//
//  FilterMenu.swift
//  cpen441mock
//
//  Created by Christine Jiang on 2025-03-26.
//

import SwiftUICore
import SwiftUI

let roomNames = [
    "2001-Project Room",
    "2003-Project Room",
    "2005-Project Room",
    "2007-Project Room",
    "2009-Project Room",
    "2011-Project Room",
    "2013-Project Room"
]


struct Checkbox: View {
    var isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        Image(systemName: isSelected ? "checkmark.square" : "square")
            .resizable()
            .frame(width: 20, height: 20)
            .onTapGesture {
                onTap()
            }
    }
}

struct FilterMenu: View {
    @Binding var showFilter: Bool
    @Binding var selectedRoomNames: Set<String>
    @Binding var minCapacity: Int
    @Binding var selectedResourceType: String

    @State private var selectedRooms: Set<String> = []
    @State private var tempMinCapacity: String = ""
    @State private var tempResourceType: String = "-All-"

    var body: some View {
        VStack {
            Text("Filter")
            HStack {
                Button("X") {
                    showFilter = false
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)

            Divider()

            // Room list with selection checkboxes
            ForEach(roomNames, id: \.self) { room in
                HStack {
                    Text(room)
                    Spacer()
                    Checkbox(isSelected: selectedRooms.contains(room)) {
                        toggleSelection(for: room)
                    }
                }
            }

            // Minimum Capacity
            Text("Minimum Capacity")
            TextField("Enter capacity", text: $tempMinCapacity)
                .keyboardType(.numberPad)
                .padding()
                .border(Color.gray)

            // Resource Type
            Text("Resource Type")
            Picker("Select resource", selection: $tempResourceType) {
                Text("-All-").tag("-All-")
                Text("Projector").tag("Projector")
                Text("Whiteboard").tag("Whiteboard")
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            Button("Filter") {
                applyFilter()
                showFilter = false
            }
        }
        .padding()
    }

    func toggleSelection(for room: String) {
        if selectedRooms.contains(room) {
            selectedRooms.remove(room)
        } else {
            selectedRooms.insert(room)
        }
    }

    func applyFilter() {
        // Pass selected room names to MainView
        selectedRoomNames = selectedRooms

        // Apply minimum capacity
        if let capacity = Int(tempMinCapacity) {
            minCapacity = capacity
        } else {
            minCapacity = 0
        }

        // Apply resource type
        selectedResourceType = tempResourceType
    }
}
