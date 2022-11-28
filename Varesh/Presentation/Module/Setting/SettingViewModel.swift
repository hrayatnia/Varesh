import Foundation
import SwiftUI
import Combine
import NetShears

final class SettingViewModel: ViewModel {
    @Published var theme: Bool = false
    @Published var unit: Bool = false

    private var useCase: SettingsUseCase = .init()
    private var cancellable: [AnyCancellable?] = []
    var appInfo: [(key: String, value: String)] {
        useCase.appInfo.sorted(by: >)
    }

    init() {
        theme = useCase.isDark
        bind()
        updateUnit()
    }

    private func bind() {
        cancellable.append( $theme.sink(receiveValue: {
            AppSettings.shared.currentTheme = $0 ? .dark : .light
        }))
    }

    private func updateUnit() {
        cancellable.append( $unit.sink(receiveValue: {
            AppSettings.shared.unit = $0 ? .imperial : .metric
        }))
    }

    deinit {
        cancellable.map { $0?.cancel() }
    }

    #if DEBUG
    func showNetworkLog() {
        NetShears.shared.startLogger()
    }
    #endif
}
