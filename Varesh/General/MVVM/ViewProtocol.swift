import Foundation
import SwiftUI

protocol ViewProtocol: View {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType { get }
}
