//
//  DessertListView.swift
//  dessertsSwiftUI
//
//  Created by Prince Avecillas on 7/16/23.
//

import SwiftUI

struct DessertListView: View {
    
    @StateObject var viewModel: DessertViewModel
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                textField
                    .onChange(of: searchText) { newValue in
                        viewModel.getSearchResults(searchText: newValue)
                    }

                List {
                    ForEach(viewModel.dessertSearch, id: \.self) { dessert in
                        NavigationLink {
                            let viewModel = DessertDetailsViewModel(dataManager: DessertDataManager(), id: dessert.id)
                            
                            DessertDetailsView(viewModel: viewModel)
                        } label: {
                            dessertCell(dessert)
                        }

                    }
                }
                .onAppear(perform: fetchData)
                .navigationTitle("Desserts")
            }
        }
        .listStyle(PlainListStyle())
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension DessertListView {
    
    private var textField: some View {
        TextField("Search", text: $searchText)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
            .autocorrectionDisabled()
    }
    
    private func dessertCell(_ dessert: Recipe) -> some View {
        HStack {
            AsyncImage(url: URL(string: dessert.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(20)
            } placeholder: {
                ProgressView()
            }
            
            Text(dessert.name)
                .font(.title)
                .padding(.leading)
            
            Spacer()
        }
    }
    
    private func fetchData() {
        Task {
            do {
                try await viewModel.fetchData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct DessertListView_Previews: PreviewProvider {
    static var previews: some View {
        DessertListView(viewModel: DessertViewModel(dataManager: DessertDataManager()))
    }
}
