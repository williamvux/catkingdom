//
//  BreedOfflineDTO.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import Foundation
import GRDB

struct BreedOfflineDTO: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName = "cat_breed"
    
    var id: String
    var breedName: String
    var data: String
    var date: Date = Date()    
    
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let data = Column(CodingKeys.data)
        static let breedName = Column(CodingKeys.breedName)
        static let date = Column(CodingKeys.date)
    }
    
    func toModel() -> CatWrapperDTO? {
        guard let jsonData = self.data.data(using: .utf8) else {
            return nil
        }
        
        return try? JSONDecoder().decode(CatWrapperDTO.self, from: jsonData)
    }
}
