//
//  ContentView.swift
//  cpen441mock
//
//  Created by Christine Jiang on 2025-03-26.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = true

    var body: some View {
        if isLoggedIn {
            NavigationView {
               MainView()
           }
        } else {
            VStack {
                TextField("Username", text: $username)
                    .padding()
                    .border(Color.gray)
                SecureField("Password", text: $password)
                    .padding()
                    .border(Color.gray)
                Button("Log In") {
                    if username == "Student" && password == "sbme" {
                        isLoggedIn = true
                    }
                }
                .padding()
            }
            .padding()
        }
    }
}

