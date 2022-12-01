//
//  VareshApp.swift
//  Varesh
//
//  Created by Sam Ray on 2022-11-25.
//

import SwiftUI
#if DEBUG && os(iOS)
import NetShears
#endif
import KWeatherService
@main
struct VareshApp: App {

    @ObservedObject var appSettings = AppSettings.shared

    @State var coordinator: AppCoordinator = .init()

    init() {
        APISetting.set(secretKey: AppSettings.shared.secretKey)
        #if DEBUG && os(iOS)
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
