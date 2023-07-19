//
//  DessertDetailsView.swift
//  dessertsSwiftUI
//
//  Created by Prince Avecillas on 7/17/23.
//

import SwiftUI

struct DessertDetailsView: View {
    
    @StateObject var viewModel: DessertDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text(viewModel.getTitle())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                image
                
                Text(viewModel.getDessertType())
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()

                instructions
                
                ingredients

                buttons
            }
            .padding()
        }
        .onAppear(perform: fetchData)
    }
}

extension DessertDetailsView {
    private var image: some View {
        AsyncImage(url: URL(string: viewModel.getRecipeImageURL())) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .cornerRadius(150)
                .padding()
        } placeholder: {
            ProgressView()
        }
    }
    
    private var instructions: some View {
        VStack {
            Text("Instructions:")
                .underline(true)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(viewModel.getInstructions())
                .font(.subheadline)
        }
    }
    
    private var ingredients: some View {
        VStack {
            Text("Ingredients:")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(0..<viewModel.getNumberOfRows(), id: \.self) { index in
                HStack {
                    Text(viewModel.getCellText(for: index))
                        .font(.title3)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical)
    }
    
    private var buttons: some View {
        VStack {
            if let youtubeURL = viewModel.getLink(type: .youtube) {
                Link(destination: youtubeURL) {
                    Text("Go to YouTube")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.cornerRadius(10).shadow(radius: 10))
                }
            }

            if let sourceURL = viewModel.getLink(type: .source) {
                Link(destination: sourceURL) {
                    Text("Go to source")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.brown.cornerRadius(10).shadow(radius: 10))
                }
            }
        }
        .padding(.vertical)
        .padding(.bottom, 70)
    }

    private func fetchData() {
        Task {
            do {
                try await viewModel.fetchData()
            }
        }
    }
}

struct DessertDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailsView(viewModel: DessertDetailsViewModel(dataManager: DessertDataManager(), id: "53049"))
    }
}
