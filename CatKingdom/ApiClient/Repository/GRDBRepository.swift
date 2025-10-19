//
//  GRDBRepository.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//
import Foundation
import GRDB

protocol GRDBRepositoryProtocol {
    func migrator()
}

class GRDBRepository {
    static let queue: DatabaseQueue? = {
        let dbFileName: String = "caches.sqlite"
        var path = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        path = path?.appendingPathComponent(dbFileName)
        
        if let pathStr = path?.path {
            return try? DatabaseQueue(path: pathStr)
        }
        
        return nil
    }()
    
    
    func deleteAll<T: PersistableRecord>(_ type: T.Type) {
        guard let q = Self.queue else {
            return
        }
        
        _ = try? q.write { db in
            try? T.deleteAll(db)
        }
    }
}
