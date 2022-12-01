import Foundation
import SwiftUI
import Combine
#if DEBUG && os(iOS)
import NetShears
#endif

final class SettingViewModel: ViewModel {
    @Published var theme: Bool = false
    @Published var unit: Bool = false

    private var useCase: SettingsUseCase = .init()
    var appInfo: [(key: String, value: String)] {
        useCase.appInfo.sorted(by: >)
    }

    init() {
        theme = useCase.isDark
        unit = useCase.unit
    }

    func updateTheme(_ state: Bool) {
        AppSettings.shared.currentTheme = state ? .dark : .light
    }

    func updateUnit(_ state: Bool) {
        AppSettings.shared.unit = state ? .imperial : .metric
    }

    #if DEBUG && os(iOS)
    func showNetworkLog() {
        NetShears.shared.startLogger()
        NetShears.shared.presentNetworkMonitor()
    }
    #endif
}
