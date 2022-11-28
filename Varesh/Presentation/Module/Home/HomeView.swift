import SwiftUI

struct HomeView: ViewProtocol {
    typealias ViewModelType = HomeViewModel

    var viewModel: ViewModelType

    var body: some View {
        EmptyView()
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .init())
    }
}
#endif
