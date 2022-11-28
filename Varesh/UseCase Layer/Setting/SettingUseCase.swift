import Combine
import SwiftUI

struct SettingsUseCase {
    var isDark: Bool {
        AppSettings.shared.currentTheme == .dark
    }

    var unit: Bool {
        AppSettings.shared.unit == .imperial
    }

    var appInfo: [String: String] {
        AppSettings.shared.appInfo
    }

}
