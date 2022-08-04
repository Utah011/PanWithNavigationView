//
//  PanPanApp.swift
//  Shared
//
//  Created by ha$min on 04.08.2022.
//

import SwiftUI

@main
struct PanPanApp: App {
    
    @StateObject var pm = PanManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pm)
        }
    }
}
