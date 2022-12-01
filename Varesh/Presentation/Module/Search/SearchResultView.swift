//
//  SearchResultView.swift
//  Varesh
//
//  Created by Sam Ray on 2022-11-29.
//

import SwiftUI

struct SearchResultView: ViewProtocol {

    typealias ViewModelType = SearchResultViewModel

    @StateObject var viewModel: ViewModelType = .init()

    @Binding var text: String

    var body: some View {
        VStack {
            Text("searching for: \(text)").onChange(of: text, perform: {_ in viewModel.search(for: text)})
            List(viewModel.cities) { city in
                Text(city.name)
                    .onTapGesture {
                        viewModel.showWeatherDetail(city)
                    }
            }
        }
    }
}
