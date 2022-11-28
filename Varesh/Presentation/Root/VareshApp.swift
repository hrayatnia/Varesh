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

    init() {
        #if DEBUG
        NetShears.shared.startListener()
        NetShears.shared.startLogger()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            AppCoordinator().view()
                .preferredColorScheme(appSettings.currentTheme.colorScheme)
        }
    }
}
