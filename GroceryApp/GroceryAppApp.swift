//
//  GroceryAppApp.swift
//  GroceryApp
//
//  Created by Mohammad Azam on 10/21/20.
//

import SwiftUI
import Firebase

@main
struct GroceryAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
