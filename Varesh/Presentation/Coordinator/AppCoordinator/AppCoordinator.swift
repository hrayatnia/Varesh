import Foundation
import SwiftUI
import Stinsen

final class AppCoordinator: AppCoordinatorInterface,
                            Stinsen.NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<AppCoordinator> =  Stinsen.NavigationStack(initial: \AppCoordinator.start)

    @Root var start = makeStart

    lazy var routerStorable: AppCoordinatorInterface = self

    func makeStart() -> NavigationViewCoordinator<HomePageCoordinator> {
        NavigationViewCoordinator(HomePageCoordinator())
    }

}
