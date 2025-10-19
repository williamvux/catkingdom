//
//  String+Extensions.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

extension String {
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var asNil: String? {
        if trimmed.isEmpty {
            return nil
        }
        
        return self
    }
}
