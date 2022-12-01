//
//  VareshApp.swift
//  Varesh
//
//  Created by Sam Ray on 2022-11-25.
//

import SwiftUI
import NetShears
@main
struct VareshApp: App {

    @ObservedObject var appSettings = AppSettings.shared

    @State var coordinator: AppCoordinator = .init()

    init() {
        #if DEBUG
        NetShears.shared.startListener()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            coordinator.view()
                .preferredColorScheme(appSettings.currentTheme.colorScheme)
        }
    }
}
