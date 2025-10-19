//
//  CatService.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import UIKit
import Combine

final class CatService: CatDAO {
    private let queue = DispatchQueue(label: "com.catkingdom.cat")
    
    enum CatError: Error {
        case decodingFailed
    }
    
    var cancellables: Set<AnyCancellable> = []
    
    private let repo: CatRepository
    private let repoOffline: CatRepositoryOffline
    
    private let network = NetworkMonitor.shared
    
    init(repo: CatRepository = CatRepository(), repoOffline: CatRepositoryOffline = CatRepositoryOffline()) {
        self.repo = repo
        self.repoOffline = repoOffline
    }
    
    
    func getBreeds(limit: Int = 50, page: Int = 0, search: String, _ completion: @escaping (Result<[CatWrapperDTO], CatError>) -> Void) {
        if !network.isConnected {
            let breeds = repoOffline.getBreeds(limit: limit, page: page, search: search)
            completion(.success(breeds))
            return
        }
        repo.getBreeds(limit: limit, page: page, search: search)
            .subscribe(on: queue)
            .sink { error in
                //
            } receiveValue: { response in
//                let json = try? JSONSerialization.jsonObject(with: response.data)
//                print(json)
                let breeds = try? JSONDecoder().decode([CatWrapperDTO].self, from: response.data)
                
                if let breeds = breeds {
                    completion(.success(breeds))
                } else {
                    completion(.failure(.decodingFailed))
                }
            }
            .store(in: &cancellables)
    }
    
    func saveBreed(_ breed: CatWrapperDTO) {
        repoOffline.saveBreed(breed)
    }
}
