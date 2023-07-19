//
//  dessertsSwiftUIApp.swift
//  dessertsSwiftUI
//
//  Created by Prince Avecillas on 7/16/23.
//

import SwiftUI

@main
struct dessertsSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            DessertListView(viewModel: DessertViewModel(dataManager: DessertDataManager()))
        }
    }
}
