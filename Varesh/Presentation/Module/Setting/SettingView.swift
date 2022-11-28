import SwiftUI

struct SettingView: ViewProtocol {
    typealias ViewModelType = SettingViewModel

    @StateObject var viewModel: ViewModelType

    var body: some View {
            Form {
                appearanceSection
                infoSection
            }.navigationTitle(Text(Constants.settingTitle.rawValue))
    }

    fileprivate enum Constants: String {
        case settings = "Settings"
        case settingTitle = "Settings Page"
        case appearanceSection = "Appearance"
        case darkTheme = "Theme Light/Dark"
        case infoSection = "Info"
        case unitToggle = "Unit (metric/imperial)"
    }
}

extension SettingView {
    var appearanceSection: some View {
        Section {
            Toggle(Constants.darkTheme.rawValue, isOn: $viewModel.theme)
            Toggle(Constants.unitToggle.rawValue, isOn: $viewModel.unit)
            #if DEBUG
            Button("Network Logs", action: viewModel.showNetworkLog)
            #endif
        } header: {
            Text(Constants.appearanceSection.rawValue)
        }
    }

     var infoSection: some View {
        Section {
            List {
                ForEach(viewModel.appInfo,
                        id: \.key) { key, value in
                    buildInfoRow(key, value)
                }
            }
        } header: {
            Text(Constants.infoSection.rawValue)
        }
    }

    fileprivate func buildInfoRow(_ key: String, _ value: String) -> some View {
        HStack {
            Text("\(key)")
            Spacer()
            Text("\(value)")
                .fontWeight(.light)
                .foregroundColor(.gray)

        }
    }
}

#if DEBUG
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingView(viewModel: .init())
        }
    }
}
#endif
