//
//  ContentView.swift
//  Varesh
//
//  Created by Sam Ray on 2022-11-25.
//

import SwiftUI

struct ContentView: ViewProtocol {
    typealias ViewModelType = ContentViewModel

    @StateObject var viewModel: ContentViewModel

    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}