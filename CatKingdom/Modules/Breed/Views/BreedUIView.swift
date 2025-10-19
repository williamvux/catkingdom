//
//  BreedUIView.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import SwiftUI

struct BreedUIView: View {
    @ObservedObject var viewModel: BreedViewModel
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                TextField("Search breed", text: $viewModel.searchText)
                    .font(.footnote)
                    .padding(8)
                    .roundedBorder(
                        lineWidth: 1,
                        borderColor: .gray,
                        radius: 8,
                        corners: .allCorners
                    )
            }
            if viewModel.isLoading {
                LoadingUIView()
            } else {
                if viewModel.breeds.isEmpty {
                    VStack {
                        Spacer()
                        LottieUIView(filePath: "splash_cat")
                            .square(of: 300)
                            .frame(height: 150)
                        Text("No breeds")
                            .font(.callout)
                        Spacer()
                        Spacer()
                    }
                    .opacity(0.2)
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            if !NetworkMonitor.shared.isConnected {
                                HStack {
                                    Spacer()
                                    Text("You are in offline mode")
                                        .padding(.vertical, 8)
                                    Spacer()
                                }
                                .padding(.horizontal, 8)
                                .roundedBorder(
                                    lineWidth: 1,
                                    borderColor: .gray,
                                    radius: 8, corners: .allCorners)
                                .padding(1)
                                .opacity(0.3)
                                .padding(.bottom, 8)
                            }
                            ForEach(viewModel.breeds, id: \.id) { cat in
                                BreedItem(cat: cat) {
                                    await viewModel.saveBreed(cat)
                                } getUIImage: {
                                    viewModel.getUIImage(from: cat)
                                }
                            }
                            if viewModel.breeds.count > 10 {
                                HStack {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .onAppear {
                                            viewModel.fetchMoreBreeds()
                                        }
                                }
                                .frame(height: 50)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    BreedUIView(viewModel: .init())
}


struct BreedItem: View {
    private enum SavingState {
        case canDownload
        case downloading
        case downloaded
    }
    let cat: CatWrapperDTO
    @State private var savingState: SavingState = .canDownload
    var onSave: () async -> Void
    var getUIImage: () -> UIImage
    
    var body: some View {
        HStack(alignment: .top) {
            Group {
                if NetworkMonitor.shared.isConnected {
                    AsyncImage(url: URL(string: cat.url)) { image in
                        image.resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .opacity(0.3)
                    }
                } else {
                    Image(uiImage: getUIImage())
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: 100)
            .roundedBorder(
                lineWidth: 0,
                borderColor: .clear,
                radius: 8,
                corners: .allCorners
            )
            .clipped()
            
            if let breed = cat.breeds.first {
                VStack(alignment: .leading) {
                    Text(breed.name)
                        .font(.headline)
                    Text(breed.description)
                        .font(.subheadline)
                        .lineLimit(2)
                }
            }
            
            if NetworkMonitor.shared.isConnected {
                switch savingState {
                    case .canDownload:
                        Image(systemName: "arrow.down.circle.fill")
                            .foregroundStyle(.gray)
                            .onTapGesture {
                                Task { @MainActor in
                                    self.savingState = .downloading
                                    await onSave()
                                    try? await Task.sleep(nanoseconds: UInt64(1) * 1_000_000_000)
                                    self.savingState = .downloaded
                                }
                            }
                    case .downloading:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    case .downloaded:
                        Image(systemName: "checkmark")
                            .foregroundStyle(.gray)
                }
            }
        }
    }
}
