//
//  CatRepositoryOffline.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import GRDB
import Foundation

final class CatRepositoryOffline: GRDBRepository, GRDBRepositoryProtocol {
    override init() {
        super.init()
        self.migrator()
    }
    var cancellables: [AnyDatabaseCancellable] = []
    func migrator() {
        guard let q = Self.queue else {
            return
        }
        var migrator = DatabaseMigrator()
        migrator.registerMigration("v1_cat_breed") { db in
            try db.create(table: BreedOfflineDTO.databaseTableName) { t in
                t.column("id", .text).primaryKey()
                t.column("breedName", .text).notNull()
                t.column("data", .text).notNull()
                t.column("date", .date).notNull()
            }
        }
        
        
        try? migrator.migrate(q)
    }
    
    func getBreeds(limit: Int, page: Int, search: String) -> [CatWrapperDTO] {
        guard let q = Self.queue else {
            return []
        }
        do {
            return try q.read { db in
                var query = BreedOfflineDTO.order(BreedOfflineDTO.Columns.date)
                if let text = search.asNil {
                    query = query.filter(BreedOfflineDTO.Columns.breedName.like("%\(text)%"))
                }
                
                query = query.limit(limit, offset: page * limit)
                
                let cats = try query.fetchAll(db)
                var result: [CatWrapperDTO] = []
                for cat in cats {
                    if let cat = cat.toModel() {
                        result.append(cat)
                    }
                }
                
                return result
            }
        } catch {
            return []
        }
    }
    
    func saveBreed(_ dto: CatWrapperDTO) {
        do {
            guard let jsonData = try? JSONEncoder().encode(dto), let jsonString = String(data: jsonData, encoding: .utf8) else { return }
            _ = try Self.queue?.write { db in
                try BreedOfflineDTO(
                    id: dto.id,
                    breedName: dto.breeds.first?.name ?? "",
                    data: jsonString
                ).insert(db)
            }
        } catch {
            //
        }
    }
    
//    func remove(_ dto: CatWrapperDTO) {
//        do {
//            _ = try Self.queue?.write { db in
//                try BreedOfflineDTO.deleteOne(db, key: dto.id)
//            }
//        } catch {
//            //
//        }
//    }
}
