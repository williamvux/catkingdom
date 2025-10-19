//
//  CatDAO.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import Foundation

protocol CatDAO {
    func getBreeds(
        limit: Int,
        page: Int,
        search: String,
        _ completion: @escaping (Result<[CatWrapperDTO], CatService.CatError>) -> Void
    )
}
