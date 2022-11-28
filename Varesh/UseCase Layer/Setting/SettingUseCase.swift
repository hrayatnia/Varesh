import Combine
import SwiftUI

struct SettingsUseCase {
    var isDark: Bool {
        AppSettings.shared.currentTheme == .dark
    }

    var appInfo: [String: String] {
        AppSettings.shared.appInfo
    }

}
