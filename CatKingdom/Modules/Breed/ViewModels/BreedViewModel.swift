//
//  BreedViewModel.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import UIKit
import Combine

final class BreedViewModel: ObservableObject {
    private let service: CatService
    
    @Published var breeds: [CatWrapperDTO] = []
    @Published var isLoading: Bool = false
    
    @Published var searchText: String = ""
    private var isLoadingMore: Bool = false
    
    private var page: Int = 0
    init(service: CatService = .init()) {
        self.service = service
        isLoading = true
        $searchText
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.isLoading = true
                self.fetchBreeds(addMore: false)
            }
            .store(in: &service.cancellables)
    }
    
    private func fetchBreeds(addMore: Bool) {
        service.getBreeds(limit: 20, page: page, search: searchText) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let breeds):
                        if addMore {
                            self.breeds.append(contentsOf: breeds)
                        } else {
                            self.breeds = breeds
                        }
                    case .failure(let error):
                        self.breeds = []
                        print("Error: \(error)")
                }
                self.isLoading = false
                self.isLoadingMore = false
            }
        }
    }
    
    func fetchMoreBreeds() {
        if isLoadingMore {
            return
        }
        page += 1
        isLoadingMore = true
        fetchBreeds(addMore: true)
    }
    
    func saveBreed(_ breed: CatWrapperDTO) {
        service.saveBreed(breed)
    }
}
