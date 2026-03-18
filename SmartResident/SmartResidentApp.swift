//
//  SmartResidentApp.swift
//  SmartResident
//
//  Created by Diana Alejandra Pava A on 16/03/26.
//

import SwiftUI

@main
struct SmartResidentApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardRouter.build()
        }
    }
}
